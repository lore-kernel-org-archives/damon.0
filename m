Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7127C41C71
	for <damon@lists.linux.dev>; Tue,  2 Dec 2025 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764639937; cv=none; b=nPuZKtO7UEx6AiGLF2VdCpcGmnuTDJi731Ona+7cAKqWVQN1LMwgGeSugZZU14i7wPe7bi0h1MsBpRPc4U9YGgRUrMhsM9leeCZgje2itln1Hreed/wz9B/zfzxSYRTUxkg85NcON6hipP9U9MbpCeac2+//+W1Ae/5TWHiufEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764639937; c=relaxed/simple;
	bh=6yr8npr+GuLK5Sm0HaPTyeaMz8yXBvcuO7m13RabMaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxkbD8keRx6mliRELT4A/8P3zR63yKgMI2xQty/saLpaMejaMttnRrj1zhXhKwxNsVtCXUpYNLxsv5nGLFwflbeXdpfLlk7xzxxRTjZDEpIrF3JOCwMd8bOeGMgzG0HcaDsfmuhaurW06kVnqdRYgYs4Q8dvDOwdMUczHjgq9/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VanZVeio; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VanZVeio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1288C4CEF1;
	Tue,  2 Dec 2025 01:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764639936;
	bh=6yr8npr+GuLK5Sm0HaPTyeaMz8yXBvcuO7m13RabMaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VanZVeiomNSt2GNECszvQhjDH/7V6CBIxxEJesgrlCB5ZGIke68b9AeEJ5oTA9xcE
	 Pmu50c1blzOjzOW+YUSGPP76SzOK5OquSXcGqzEZ7LyqCV2B4BUw7nMYFkYKHG7BZ4
	 sA3sSqUJ7Xj1NnTwEPHseLytDwB7W1j0AlTBPamjrKKM1L82FPn+/9BziO4ihk7UH7
	 G0TBfMjKzYT8sRmOSDlgalyjHvvFRL0qKoe7Ty7AhzQi3qmwfn/FNUkVMhzIaRYcxf
	 zbma1fG3CiZvQx3nDCnbHOXDYkzZ4+W894nLAqfgYAkUzPXrSQjuzkqiQlnGeGErNQ
	 PbqAluVU+WgAg==
From: SeongJae Park <sj@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	Xin Hao <xhao@linux.alibaba.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Andrew Paniakin <apanyaki@amazon.com>
Subject: Re: A rough plan for CPUs/write-only monitoring RFC v3 and future
Date: Mon,  1 Dec 2025 17:45:32 -0800
Message-ID: <20251202014532.71857-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <28004730-6394-4c5b-949e-8ef15b0642af@lucifer.local>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 1 Dec 2025 10:22:14 +0000 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Fri, Nov 28, 2025 at 11:39:46AM -0800, SeongJae Park wrote:
[...]
> > This work require multiple changes including
> > 1. extending DAMON for receiving access report from other subsystems
> >    (damon_report_access() [9]),
> > 2. making other subsystem who can capture origin CPU/writeness of accesses
> >    (e.g., page fault handler [10]) report the information to DAMON,
> > 3. extending DAMON for filtering the reports for origin CPU/writeness of
> >    accesses.
> >
[...]
> > For the second part, I'm trying to modify the page fault handler, to use
> > information like NUMA balancing hint faults.  As Lorenzo pointed out on RFC v2,
> > it needs to have clean and non disruptive design.  Also this requires alignment
> > of multiple stakeholders, including MM core and NUMA balancing maintainers.  I
> > think this is the biggest challenge of this project.  Using other subsystems or
> > features such as instruction sampling can be another way to go.  But for
> > general availability of it on any architecture and virtual machine internal
> > cases, people I privately discussed preferred this fault based approach.  I
> > will try to make the alignment with the stakeholders, after the upcoming LPC [11].
> > Unless I make good progress on this part very quickly, I will propose an
> > LSFMMBPF'26 [12] session for this.  So hopefully we will make some alignment
> > among the stakeholders by LSFMM.  Hopefully we will get a more concrete
> > upstreaming plan and timeline, at least after the LSFMM'26.
> 
> I think it will be difficult (though not saying impossible :) to get alignment
> on overload NUMA for this, I think at the very least we'd have to _allow_ for
> there to be clashes between the two and possibly spurious results in either
> direction.
> 
> I think my recent softleaf changes should at least make this more
> viable. Though, if you wish to retain the entire PTE entry it doesn't seem
> feasible to utilise this, but rather we'd have to simply overload NUMA (and
> possibly rename it to something else...)
> 
> Another way might be to, when marking PTEs for the DAMON mechanism, store the
> complete PTE entry elsewhere, insert a softleaf entry that contains the index of
> this entry, and on fault restore it from this 'elsewhere' location.
> 
> I have some doubts that overloading NUMA is going to be something that'll be
> upstreamable, because of the added complexity and natural clashes between NUMA
> and this new mechanism.
> 
> So perhaps this alternative will work better?

Thank you for sharing your concerns and even this shiny new idea, Lorenzo!  I
will take more time on this after LPC and share my thought, before the upcoming
LSFMMBPF.

[...]
> > To summarize the major expected timeline here,
> >
> > 1. By LPC'25 (2025-12-13), another version having stabilized DAMON interface
> >    will be shared.
> > 2. By LSFMMBPF'26 (2026-05-06), an alignment on part 2 stakeholders will be
> >    made.
> 
> Sadly I am not attending LPC '25, but of course intend to be there at LSF '26 :)

No worry, I'm looking forward to see you next year! :)


Thanks,
SJ

[...]
