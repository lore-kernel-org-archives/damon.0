Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E824C1D88D0
	for <damon@lists.linux.dev>; Fri, 28 Nov 2025 19:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764359491; cv=none; b=Sf/fee6yzPcjRhsxghxmUOkjfxNMtG+wW8k+hAV4ILlg3hwjTHuVy92cy94wdA3Dxu75AR/pTNAICr2GhGSUEJxNGuxjb6wb3g6hVOkbFrPV2hWDv7PAGArhVCjpLfuUjswzCdZjgiNUFHHMbARHaE+py43ZuBmzBAz2ypYJIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764359491; c=relaxed/simple;
	bh=NR06UM6epC0ZB0HG7Po42G/+BGWua8g9q5A5Ak9ER9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teqndKwTOG1CYb8H6c0yMTc1VbhhjsqIPAIlgnQlxaZ0uBpWB/GuMBO5vqRhrFeWir3h+aNw0N1W/b9EjfpnzqKEag0QeIkrb/hRYJNHS4Z2fm1igA2fbKkGBdyTxSto9mZYreftx1bVasWMd2lEjEqsB6kKk2JPLSJ4XXRT2Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDUX0aHo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDUX0aHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3939AC4CEF1;
	Fri, 28 Nov 2025 19:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764359490;
	bh=NR06UM6epC0ZB0HG7Po42G/+BGWua8g9q5A5Ak9ER9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDUX0aHoVVdYpplIWWEnJQsduHQha8bvV/5+IXyPLpqt2WB7ofVD97rjBLys5COF7
	 2VwhXh1WV0Z+G0oOuZrMkuBciZAjehGBN+WGIsPPG+cLki79FQnmts2W3cPv++N+7+
	 AdgWB5sGerJAqJvkVfwUiONi7iXTeHjC/IQXXQEwn2aa/eyEYZG9NJwRhUf8zEBsXl
	 qiT/ZWdmgCYtBW2xcrCoBMgTxT3xLkuuqoKcxm/61NeVt6lEJNfgoOsUfFbtDFTOKu
	 0qPFbDYZTnKX1zOzCibC4zViHH5LwJskk4xnWKF5ZN/PHkbJgcEGEUFrMhE7fYi4PC
	 M0vGLTLdTrYug==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	Xin Hao <xhao@linux.alibaba.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Andrew Paniakin <apanyaki@amazon.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-mm@kvack.org
Subject: Re: A rough plan for CPUs/write-only monitoring RFC v3 and future
Date: Fri, 28 Nov 2025 11:51:20 -0800
Message-ID: <20251128195121.81042-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128193947.80866-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ linux-mm@

On Fri, 28 Nov 2025 11:39:46 -0800 SeongJae Park <sj@kernel.org> wrote:

> Hello DAMON community,
> 
> 
> I'm working [1] on extending DAMON to monitor accesses that are made by
> specific CPUs, and/or for writes.  The aimed usages include NUMA hit/miss
> monitoring [2], Kernel Same page Merging scan target selection [3,4], cache
> aware CPU scheduling, live migration target VM selection [5], and general
> NUMA-aware pages migration [6].
> 
> I posted its first working version as RFC v2 [7] about four months ago.  After
> the posting, it got interests and tests publicly [5] and privately.  RFC v2
> was, however, a never upstreamable hack that was made for only showing if it
> can be implemented.  For making it upstreamed, a significant amount of efforts
> are expected [8].  And after the posting, I was unfortunately unable to spend
> meaningful time on it due to other events and work.  I received more continued
> interests in the work recently, and hence I'm trying to spend more time on it.
> 
> The Rough Plan
> --------------
> 
> The rough plan of it that I shared on DAMON blog [8] was just saying "it needs
> to be upstreamed and it will require a significant amount of effort".  So I'm
> sharing yet another rough plan here.
> 
> This work require multiple changes including
> 1. extending DAMON for receiving access report from other subsystems
>    (damon_report_access() [9]),
> 2. making other subsystem who can capture origin CPU/writeness of accesses
>    (e.g., page fault handler [10]) report the information to DAMON,
> 3. extending DAMON for filtering the reports for origin CPU/writeness of
>    accesses.
> 
> The first part in the current implementation has many rooms to improve in terms
> of performance.  I don't think that's upstreaming blocker though, unless some
> early testers find a problem of it.  So I think this is not a blocker for this
> project, at least at the moment.
> 
> For the second part, I'm trying to modify the page fault handler, to use
> information like NUMA balancing hint faults.  As Lorenzo pointed out on RFC v2,
> it needs to have clean and non disruptive design.  Also this requires alignment
> of multiple stakeholders, including MM core and NUMA balancing maintainers.  I
> think this is the biggest challenge of this project.  Using other subsystems or
> features such as instruction sampling can be another way to go.  But for
> general availability of it on any architecture and virtual machine internal
> cases, people I privately discussed preferred this fault based approach.  I
> will try to make the alignment with the stakeholders, after the upcoming LPC [11].
> Unless I make good progress on this part very quickly, I will propose an
> LSFMMBPF'26 [12] session for this.  So hopefully we will make some alignment
> among the stakeholders by LSFMM.  Hopefully we will get a more concrete
> upstreaming plan and timeline, at least after the LSFMM'26.
> 
> The third part in current implementation is very ugly.  Especially its kernel
> API and user ABI need to be redesigned from the beginning.  The interface is
> better to be stabilized sooner, as changes of the interface will make the early
> users/testers be confused and frustrated.  I started working on this, and
> hopefully I will share RFC v3 of this project with the stabilized interface, by
> upcoming LPC'25.
> 
> Summary and Message for User/Tester
> -----------------------------------
> 
> To summarize the major expected timeline here,
> 
> 1. By LPC'25 (2025-12-13), another version having stabilized DAMON interface
>    will be shared.
> 2. By LSFMMBPF'26 (2026-05-06), an alignment on part 2 stakeholders will be
>    made.
> 3. After the alignment, a more clear plan will be made.
> 
> If you are already using or testing RFC v2 of this project, please be aware the
> kernel API and user ABI will significantly be changed on the version that I am willing to
> share by LPC'25.  It means if you are directly using or testing the features
> via the kernel API and/or user ABI, your usages or tests might need to be
> updated.
> 
> The support of the features on DAMON user-sapce tool (damo) is also
> experimental at the moment, and that will also be changed in more stable form
> in future.  But, the experimental interface will support both before-LPC and
> after-LPC DAMON for the short term.  Hence, if you are using or testing the
> features via DAMON user-space tool's experimental interface, you will not need
> to make any change in the short term.
> 
> Please feel free to raise any questions or comments on the plan and the
> project.
> 
> References
> ----------
> 
> [1] https://damonitor.github.io/posts/write_only_cpus_only_monitoring/
> [2] https://lore.kernel.org/linux-mm/cover.1645024354.git.xhao@linux.alibaba.com/
> [3] https://lore.kernel.org/lkml/20220203131237.298090-1-pedrodemargomes@gmail.com/
> [4] https://lore.kernel.org/damon/20250129044041.25884-1-pedrodemargomes@gmail.com/
> [5] https://lore.kernel.org/all/aJAfTUh-49pYuhbg@3c06303d853a/
> [6] https://lpc.events/event/19/contributions/2066/
> [7] https://lore.kernel.org/all/20250727201813.53858-1-sj@kernel.org/
> [8] https://damonitor.github.io/posts/write_only_cpus_only_monitoring/#cautions-and-plan-to-drop-experimental-tag
> [9] https://lwn.net/Articles/1016525/
> [10] https://lore.kernel.org/all/20250727201813.53858-6-sj@kernel.org/
> [11] https://lpc.events/event/19/
> [12] https://events.linuxfoundation.org/lsfmmbpf/
> 
> 
> Thanks,
> SJ

Sent using hkml (https://github.com/sjp38/hackermail)
