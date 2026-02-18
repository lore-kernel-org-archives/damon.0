Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224025C80E;
	Wed, 18 Feb 2026 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771393405; cv=none; b=Q17hCWQfPmxAhhU4KHNdahrSGpbDsY8KLidR2P/VM2RGLXaQFU12nZVTgAKucTEekseNSVQMFzybk8XNLQH88Pvrmq6KabhF5jWuRuYWgfTpK2ViGiOEqm9LvIl/AX8E79nxE80k/RmIlLfACbFUfpCH4dsu6xYv4sE8jN5+B7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771393405; c=relaxed/simple;
	bh=L92QtPQXcBW0ot4moYIssOzoK2uvvCToQr0AXIabFAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h6+6S0hm6z4bQHi8yEF2S42Chzgf/Cbw52PUogqroTSZIiiNCBg8RJWAkhTIHNhsx0UpjMauRrv2R4xLkomWxD97GVZ6QPq0MNBJVj1lwa8hdIsu4Z8K866gvecks6IlYT/WkCUrDrLMKOfks5FdkBlvgBQfpVqNchRr93rMC1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlOgrrIH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlOgrrIH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF06C19422;
	Wed, 18 Feb 2026 05:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771393404;
	bh=L92QtPQXcBW0ot4moYIssOzoK2uvvCToQr0AXIabFAY=;
	h=From:To:Cc:Subject:Date:From;
	b=MlOgrrIHD8NewjsF/uGbKmrBMiZHalWWjRu4+Sqlg7XlRZEMQHTc4/UMfJUYgp4Q+
	 aZPyGRdoU2yk9mmqs8y4+PMVzPKF9L8d05e66cn4IRRovyNiVJXERHvA8xuJrxcpLr
	 SldWoAc0KCUKsGrXQzFGbuUTiY6czJrJGrn/q1Mxq7/K7fKGtRLAS+jyZ27wpSLxMu
	 /D/EK1A74L82rUruQw+Qe5opBPfoHXqIrPxMNt2u+7zik093zU6zlwI/vhwTjsGM2H
	 qgmPPl7vBozWgbGg/uObr93jRGo/PNvAECeGqujCQC9BT4oUhz7NWpMeqX5PlUp2T5
	 nhw2uAl9eDnag==
From: SeongJae Park <sj@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mel Gorman <mgorman@suse.de>,
	Huang Ying <ying.huang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Paniakin <apanyaki@amazon.com>
Subject: [LSF/MM/BPF TOPIC] Allowing NUMA hinting faults or alternatives to DAMON
Date: Tue, 17 Feb 2026 21:43:19 -0800
Message-ID: <20260218054320.4570-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


Why DAMON wants/needs to use NUMA hinting faults infrastructure
---------------------------------------------------------------

There are users who want to use DAMON for access-aware threads scheduling,
inter-NUMA pages migration, and fidning easiest live migration target virtual
machines (dirtying its memory in the slowest speed).  For this, we want to
extend DAMON to be able to monitor accesses filtered by the accessor and access
type information.  More specifically, access monitoring per CPUs, threads,
reads, and writes.

At the moment, DAMON uses page table Accessed bits as the main primitives for
collecting the access information.  This means that DAMON can know only whether
a given page is accessed or not within a given time period.  It cannot know who
made the access, and whethr the access was for a read or a write.  To implement
the extension, therefore, DAMON should be able to use other primitives.

We think NUMA hinting fault (or, prot_none faults on accessible vma) is the
best candidate of the new primitive, for following reasons.  The infrastructure
is developed and being used for a sort of similar purpose: finding hot pages
for NUMA balancing.  The infrastructure also works on most common architectures
and virtual machines.  For example, a DAMON patch series that aims to do
similar extension using perf events [1] was posted recently.  But we found it
is not available [2] inside virtual machines and some old architectures.  Users
of the above mentioned use cases plan to run DAMON inside virtual machines and
some old machines, so I think that's not the best option for them.

Current development status and challenges
-----------------------------------------

Hence, we developed a prototype and shared it as a few revisions of RFC patch
series [3].  The patch series is mostly for DAMON internal change, but also
adds a small but un-upstreamable hack [4] to the core of MM, specifically
change_protection() and page fault handling.  Lorenzo clearly and kindly raised
his concern about the hack in a previous version of the patch series.  David
also shared a receent discussion that could give good idea about its future, to
the latest revision of the RFC patch series.  Based on the thankful feedback
and my self review, I find two major problems on the hack.

First, the hack is adding DAMON-exceptional code into the core of the page
fault handling, making it difficult to maintain.  I'm planning to cleanup and
refactor the related code so that NUMA hinting faults infrastructure becomes
more generally re-usable and easier to maintain for both NUMA balancing and MM
core developers.

Second problem is more important and challenging in my humble opinion.  The
problem, or the question, is how we should handle interferences between DAMON
and NUMA balancing, that come from their shared use of NUMA hinting faults
infrastructure.  Should they be allowed to fully share the infrastructure at
same time?  Apparently not.  I think they can be exclusive at build time via a
kernel config, or at runtime.  I think the runtime option is desirable due to
its flexibility.

If we make them exclusive at runtime, in what extent those should be isolated?
Should they completely be exclusive?  Then we may need to make them use the
infrastructure in completely exclusive time.  Also they should uninstall
prot_none protections that they added, before they stop using the
infrastructure and allow the other to use it exclusively.  Otherwise, DAMON may
receive fault information that made by NUMA balancing-installed prot_none
protections, and vice versa.

The uninstall of their prot_none may make the behavior simple and easy to
understand.  But I'm wondering if it is unnecessary overhead and complexity.
That is, letting them seeing the faults caused by prot_none protections that
installed by the other might not be a real problem.  First of all, I don't
think users will really turn on and off NUMA balancing and DAMON multiple times
on a running system.  Showing faults that caused by others would be quite
rare events.  Secondly, DAMON is providing only a best effort accuracy, so some
of noise coming from past prot_none install of NUMA balancing shouldn't be a
big problem.  Lastly, NUMA balancing is also getting that kind of unintended
information from its past run.  That is, if I read the code correctly, NUMA
balancing installs prot_none protection to a given range of address space, get
the faults information from those and do needed migration.  After a time
window, it installs the protection on next range of the address space, and so
on, without removing the prot_none installations that made for last time
window.  Hence, letting DAMON makes some more such faults might be not a real
problem.

LSF/MM/BPF discussion proposal
------------------------------

I might misreading mm core and NUMA balancing code and misunderstanding real
concerns from the subsystem developers.  I also worried if I'm biased only to
make my implementation simple.  I therefore want to make high level agreements
with all related stakeholders, first, before taking too much efforts on a wrong
direction.

For the reason, I want to discuss related topics with all stakeholders in
LSF/MM/BPF.  Particularly, I hope developers of the page protection setup, page
fault handling, and NUMA balancing to join the discussion.  Lorenzo and David
are MM core developers and already left their opinions on the previous RFC
sereis.  Mel Gorman is the CONFIG_NUMA_BALANCING reviewer and Huang Ying made
many great works on NUMA balancing.  People who have interest in the aimed use
case of the DAMON extension should also be welcome.  Andrew Paniakin has
particularly shown their interest and testing the prototype.  Akinobu is also
working on a similar project in a different angle, using perf events.

The high level discussion topics include but not limited to below:

- Is the aimed use cases valuable enough to let DAMON use the NUMA hinting
  faults infrastructure?
- What is the shape of the change that will make the maintenance burden not
  be increased but could even be reduced?
- What is the preferred sharing strategy?  Just sharing everything?  Build time
  config-based exclusion?  Run-time full exclusion?  Run-time half exclusion?
  What are the concerns for each options?
- Is there another candidate other than NUMA hinting faults that can also be
  usable for the aimed use cases of the extended DAMON?

References
----------

[1] https://lore.kernel.org/20260123021014.26915-1-akinobu.mita@gmail.com
[2] https://lore.kernel.org/20260127064338.67909-1-sj@kernel.org
[3] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org/
[4] https://lore.kernel.org/20251208062943.68824-6-sj@kernel.org


Thanks,
SJ
