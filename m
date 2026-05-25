Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B418B0F
	for <damon@lists.linux.dev>; Mon, 25 May 2026 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779749540; cv=none; b=X5hNRVyj3Aet2Scl4ZkFdDOn5od6fD13KmMlMjUqnbv8/IxgKrGQwUUWnnpZtdS/pzlDQ3Am2lSelA+T5xxI+poMz/011stXQ9BNUwFD0fkPuYA88qRoTggPPD9/n6nhNU0MHYMC6a5lB7uaQAWTvexhEJAEBp46cc0eu7UWHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779749540; c=relaxed/simple;
	bh=x4gh17F/5VwYl+FmW9NxwCh+s6h6ru3sFn6FuvuiYsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FEwBw174rytJDL+4MK6KDfn2D5dpJSoNbrAKC9Mb1ryQb+Jz/AJnrvH62xdlU/DQREOpd2vpRZf5JjnVN0K9myVj29Ub4PgJZwjEi6492ZnTugtRjnjFCgvMnHv058MqOYuQMcqqLuys1adtO9iCj8DcJAl/LOwZpmUiNNzBw/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHJmFpr+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHJmFpr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127C41F000E9;
	Mon, 25 May 2026 22:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779749539;
	bh=a+VgUEy54k2ZKHz04PuiQqgeWTnpg7pkoKE6eBruwgo=;
	h=From:To:Cc:Subject:Date;
	b=jHJmFpr+yvZmwSKx+QhWsjB79DnD8mR7AoqQhofPccv4xtxQToZPOwEokdLUB0dii
	 gnwpdn0ED96CzbH+obl5yz9IWgFbuYcehVp/zDeFn1VyA03CllLaDKVOHMBhdXPJmc
	 CWf0hPgxG6Qo7nQ2JViYI+9oY4HgS8ugLxGfIYANm4O5iUAUCPfgbPcBq3meo3lK2G
	 bcjZcYcoom0w0X9CHWqKIzivf4GJPl3yKECh22oGxK0vz7Ynjg9WkitmrcQVybflt7
	 +WToRvvUWqRIFFOQBiTbPCQGCVRijZRRyAETxLeeiR6SRq5xG349G9DszU7BxulkeG
	 ZMGHMOWxK4MOg==
From: SeongJae Park <sj@kernel.org>
To: damon@lists.linux.dev
Cc: SeongJae Park <sj@kernel.org>,
	Ravi Jonnalagadda <ravis.opensrc@gmail.com>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Paniakin <apanyaki@amazon.com>
Subject: Roadmap for extending DAMON beyond pte-accessed bit
Date: Mon, 25 May 2026 15:52:08 -0700
Message-ID: <20260525225208.1179-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,


TLDR: Let's extend DAMON for data attributes monitoring, andd then further
extend that for multiple access check primitives including page faults, perf
memory-access events and optimized AMD IBS-like h/w feature drivers.

Ongoing Projects
================

At the moment, DAMON is utilizing page table accessed bits as its major access
check primitive.  Because of the limitations in the primitive, interests in
extending DAMON to use different access check primitives, including page fault
events and h/w features such as AMD IBS, were expressed multiple times.

I started working [1] on the page fault events based extension for
per-CPUs/threads/reads/writes monitoring.  Akinobu is working [2] on perf
events based extension for lower overhead fixed granularity monitoring.  Ravi
is working [3] on AMD IBS based extension for memory tiering.

Xin Hao proposed [4] extending DAMON for NUMA systems in 2022.  Pedro Demarchi
Gomes proposed [5,6] extending DAMON for write-only monitoring in 2022 and
2025.  My page faults based monitoring extension is partly for their projects.

Types of Required Works
=======================

Each work commonly requires three types of changes.  Startign from the lowest
layer, the required changes are as below.

Firstly, we need to extend existing DAMON operation set (paddr and vaddr) or
implement a new one for controlling the new access check primitives.  This
part, at least for page fault events and perf events are not overlapping and we
could work in parallel.

Secondly, we need DAMON core layer change for the reporting-based access check.
Page table accessed bits are set by h/w and DAMON does nothing about it.  DAMON
wait until h/w sets the bits, and later harvest the information by reading the
bits.  In other words, DAMON only "pulls" the information.  For page faults and
perf events like primitives, we need to hook the access events and "push" the
information to DAMON.  For the page fault events based extension [1], I
implemented damon_report_access() and related infrastructure for this purpose.
The implementation is quite unoptimized.  But I believe the design is good
enough for long term maintainability.  I want us to use this framework.  We can
make it works first, and later optimize.

Finally, we need DAMON user interface.  For the page fault events based
extension [1], I introduced access sampling control interface.  The idea is
letting users control the access sampling in a more detailed way.   At that
time, I was thinking it is long term maintainable and Akinobu and I could reuse
it.  I still think it would work.  But, I recently got another idea.

The new idea is extending DAMON for general data attributes monitoring.  The
first change [7] for making it able to monitor not only data access but also
general dasta attributes including anonymity of the pages and belonging memory
cgroup is recently merged into mm.git.  As the cover letter of the patch series
is also explaining, the work has started for light-weight per-cgroup access
monitoring.  But, in long term, we want to make data access information as just
one of the supported data attributes.  Then, we can further extend access
confirmation coming from different primitives as different data attributes.
For example, in addition to "PTE Accessed-bit" attribute, we can add "perf
event mem-access reported" attribute and "AMD IBS access reported" attribute.
I think this is long term maintainable and therefore want us to use this
interface.

Roadmap
=======

Assuming you agree to use the data attributes monitoring interface, I suggest
us to do the work in below roadmap.

Milestone 1: PTE Accessed bit as one of the data attributes
-----------------------------------------------------------

I will work on stabilizing and further extending the data attributes interface
and internal framework to be able to support PTE Accessed bit.  This may take
no small amount of efforts, but hopefully doable by the end of this year.

Milestone 2: First damon_report_access()-based data attribute monitoring
------------------------------------------------------------------------

Once the first milestone is completed, we will add the damon_report_access()
and related infrastructure changes into the DAMON core.  On top of it, we will
further implement the first data attribute that utilizing the reporting
infrastructure.  I personally think the perf event based one is a good target
at the momentt.  I think so mainly because the perf maintainers didn't show
special concern yet.  We can discuss the target again after the first milestone
is completed, though.  Hopefully this is doable by the LSFMMBPF 2027.

The timeline is just a gut feeling.  It could be done much earlier or later.

Milestone 3: Parallel extenstion for other primitives
-----------------------------------------------------

After milestone 2 is done, we have the user interface and the infrastructure.
We will be able to further implement our favorite access check primitives on
top of it in individual schedule, without blocked by each other.

Collaboration
=============

Milestone 1 and damon_report_access() part of milestone 2 would need to
primarly done by myself.  If you are interested in this project, reviewing the
patches that I will post for the milestones and doing some testing would be
very helpful.

For the second half of milestone 2, I may need more help from Akinobu, Ravi or
someone else who may experienced with the first target primitive.  Maybe I
could develop the damon_report_access() part and post it on the mailing list,
and the other collaborator could further develop the first target primitive
extension on top of the patches, like we did for vaddr page interleaving.
Let's discuss the details after milestone 1, though.

Request For Comments
====================

I would appreciate any inputs about this roadmap and plan.  I'm primarily
curious if the plan and the timeline makes sense to Akinobu and Ravi, who are
actively working on, and might need to wait for my milestone 1.  Also if there
are people who interested in this, please feel free to add your inputs publicly
or privately, in your preferred way.

[1] https://lore.kernel.org/20251208062943.68824-1-sj@kernel.org
[2] https://lore.kernel.org/20260423004211.7037-1-akinobu.mita@gmail.com/
[3] https://lore.kernel.org/20260516223439.4033-1-ravis.opensrc@gmail.com
[4] https://lore.kernel.org/linux-mm/cover.1645024354.git.xhao@linux.alibaba.com/
[5] https://lore.kernel.org/lkml/20220203131237.298090-1-pedrodemargomes@gmail.com/
[6] https://lore.kernel.org/damon/20250129044041.25884-1-pedrodemargomes@gmail.com/
[7] https://lore.kernel.org/20260518234119.97569-1-sj@kernel.org


Thanks,
SJ
