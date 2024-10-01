Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937ED1BCA19;
	Tue,  1 Oct 2024 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810071; cv=none; b=ZvT5CRoei8l1Lh2P1qIMEnliMaviraN0vwRJwyHXndiiVuhQtZH9ux4g4hlWODxIJJC1gNm7Cc8/hz9j+56RSNxyAfarnEDdRcKPS2tBg7nqEMuuBQtaEg1BslSUKGxeADiHAAb7sYSAXAczcMRcduqJbVC7/DicaWQar9BUcpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810071; c=relaxed/simple;
	bh=1o3xkKDxJdtkE8fgqL+WN2XSbXjNaOd+iHfQfqSiNLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pmq/WdUXffhq5/HJVqq+6GXrjzsRhX1SKHyiN3KmVOFYVXsgsnpyNLAeklNAJvhqKAQ4oAt8qbX3rwVgQBPgPOBivG/1R3BUsxjtDbEYT73135in/u6R/Im8YXtAj0+Nt2MtO5pVIgHUeSHtnfeeNUAQnzVaTm8+E/EvkDcyV90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4dXciEH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4dXciEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9C5C4CEC6;
	Tue,  1 Oct 2024 19:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727810071;
	bh=1o3xkKDxJdtkE8fgqL+WN2XSbXjNaOd+iHfQfqSiNLY=;
	h=From:To:Cc:Subject:Date:From;
	b=t4dXciEHyaKIkUR03pyVn5lnVZEGNg7JvOVwcOx9OOH2n6PuxRZDwXQz5cYV2fACi
	 yTqQqTjUkPN8uhrrustRtTTQWKS3ZNOEemLNam/SBbkoMpQsf4BkMgLUqaOQmsJsoO
	 2tQISWwvsktjKXQv/CUkZArnmElzGMQEeSmmxZaGZNn6LxTzhFApuzb2kGQem6a6e2
	 /VVifbZMoOCpqMCgepS+y8qlBaEaBLBJmc8XfQ+21hV9RyqQBFMkWrW+D/dBJp94kK
	 jfWLiKWlkOLsCamFJ+TfLjJ0YY+BuBt+EKmFm2MJf4CQTov3ylipp9KXe8ZUJC/3By
	 uEZ7OG2NZnn4A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: DAMON Quaterly News Letter (2024 Q3)
Date: Tue,  1 Oct 2024 12:14:24 -0700
Message-ID: <20241001191425.588219-1-sj@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello DAMON community,


Three more months have passed since the last DAMON quaterly news letter[0].
Let's look back what happened in the last three months.

Highlights of Highlights
========================

- New features.  DAMON-based CXL memory tiering patchset has merged[1] into the
  mainline.
- More users.  DAMON usages from AWS Aurora Serverless v2 has unveiled[6].
  CONFIG_DAMON has enabled[9] on Debian kernels.  Six more academic papers that
  exploring and/or utilizing DAMON has published or archived on OSDI[2,3],
  ATC[4,5], VLDB[6], and ArXiv[7].  Monthly PyPI downloads of DAMON user-space
  tool (DAMO) has significantly increase.
- Re:org.  DAMON github repos have moved[8] from awslabs org to damonitor org. 
- Conferences:   Detailed DAMON usages from products and labs have presented on
  OSS EU[10] and the VLDB paper[6].  Long-term DAMON plans for kernel that
  extensible and just works have shared and discussed[11] on LPC.

More detailed list of news per each month follows.

July 2024
=========

A couple of OSDI'24 papers[2,3] for memory tiering that references and
exploring DAMON as a part of them are published.

ATC'24 also published two DAMON-citing papers at the same time. The first
one[4] proposes a way to improve monitoring accuracy of DAMON, while the second
one[5] mentions DAMON can be useful for extensible memory management.

VLDB paper about Aurora Serverless V2, which reveals their usage of DAMON on
the product, is uploaded[6].

Memory Management subsystem pull request for Linux v6.11-rc1 with DAMON changes
for CXL memory tiering has merged[1].

August 2024
===========

GitHub repos for non-kernel parts of DAMON project including 'damo',
'damon-tests' and 'damoos' have announced[8] to be moved from awslabs org to
damonitor org.  As of this writing, the reorganization is completed.

September 2024
==============

CONFIG_DAMON is enabled[9] on Debian kernels.

An academic paper preprint that optimizes THP using DAMON and BPF has
uploaded[7] to ArXiv.

DAMON usages from labs and real-world products for profiling-guided
optimizations, proactive reclamation (Auroa Serverless v2), and CXL memory
tiering (SK hynix HMSDK) have shared[10] on Linux Conference at OSSummit EU'24.

DAMON long-term plans for making kernel extensible and just works have shared
and discussed on Kernel Memory Management Micro-Conference[11] at LPC'24.

Monthly PyPI downloads of DAMON user-space tool (DAMO) surpassed 4,000.  It
took about 7 months since the record of 2,000 (2024-02), which took about 18
months from the beginning.  The speed is apparently growing.

Previous quaterly news letters
==============================

- 2024 Q2: https://lore.kernel.org/20240701212244.52288-1-sj@kernel.org
- 2024 Q1: https://lore.kernel.org/20240402191224.92305-1-sj@kernel.org

More Past DAMON News
====================

If you're interested in a humblie list of more DAMON events that happened in
past and curated by DAMON maintainer, please reach out to the project site's
news page [12].

References
==========

[0] "DAMON Quaterly News Letter (2024 Q3)",
    https://lore.kernel.org/20240701212244.52288-1-sj@kernel.org
[1] "MM updates for 6.11-rc1",
    https://lore.kernel.org/20240721145415.fbeb01a853962ef91334f3d1@linux-foundation.org
[2] "Nomad: Non-Exclusive Memory Tiering via Transactional Page Migration",
    https://www.usenix.org/conference/osdi24/presentation/xiang
[3] "Managing Memory Tiers with CXL in Virtualized Environments",
    https://www.usenix.org/conference/osdi24/presentation/zhong-yuhong
[4] "Telescope: Telemetry for Gargantuan Memory Footprint Applications",
    https://www.usenix.org/conference/atc24/presentation/nair
[5] "FBMM: Making Memory Management Extensible With Filesystems",
    https://www.usenix.org/conference/atc24/presentation/tabatabai
[6] "Resource management in Aurora Serverless",
    https://www.amazon.science/publications/resource-management-in-aurora-serverless
[7] "eBPF-mm: Userspace-guided memory management in Linux with eBPF",
    https://arxiv.org/pdf/2409.11220
[8] https://lore.kernel.org/all/20240813232158.83903-1-sj@kernel.org/
[9] https://salsa.debian.org/kernel-team/linux/-/merge_requests/1172
[10] "DAMON Recipes: Ways to Save Memory Using a Linux Kernel Subsystem in the Real World",
     https://sched.co/1ej2S
[11] "DAMON: Long-term Plans for Kernel That {Just Works,Extensible}",
     https://lpc.events/event/18/contributions/1768/
[12] https://sjp38.github.io/post/damon_news/

Wrapup
======

So, those were yet another grateful three months.  Looking forward to get more
news!  If you have any question regarding DAMON, please feel free to reach out
to the community and/or me.


Thanks,
SJ
