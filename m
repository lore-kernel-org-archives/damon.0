Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2DD2C21CD
	for <damon@lists.linux.dev>; Thu,  4 Sep 2025 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974599; cv=none; b=nlAEDazGfUvyIZM3wkyAxDHHRov1I7aNZXnPjdaXslmImP1emMokpOpmiW0i/ptNyQ7ZN5cQAmVcnQDNwhxYIperrBOhekXoZ0+c0byfYdmvrmDuTg0OE+Q4D9cdFqfHVQlQu1HIOPNjhYgJoAlCgtXgPxrTiyoIw8H+1HNlllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974599; c=relaxed/simple;
	bh=nVYV0TMgcz6q7RD3mfApily3BCsahhODfps4FbS+I8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JWbgKpOoo4BxxuDkZCVO0HDapRxDO1k3yiXQ5rG3Nuz+9o55+Eg8HbkNHZP8mSVzbmS45ckJyDE0m/ks9ZmYwuqPEVD60T3xpfRdVEsc3Ivw0b5HY45AsOSLozqTPZHfzcshUOM+E4M7ws65Lm+KfAdbGafNH5IgJDkFTs/KpJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-0b-68b94dfc617e
From: Yunjeong Mun <yunjeong.mun@sk.com>
To: sj@kernel.org
Cc: damon@lists.linux.dev,
	honggyu.kim@sk.com,
	kernel_team@skhynix.com
Subject: Re: [BUG] 'damo stop' causes kernel crash in v6.17-rc3
Date: Thu,  4 Sep 2025 17:29:45 +0900
Message-ID: <20250904082946.949-1-yunjeong.mun@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <20250904040203.1306-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsXC9ZZnoe4/350ZBj92qFo8+f+b1eLw1zdM
	Dkwem1Z1snm82DyTMYApissmJTUnsyy1SN8ugSvjUlNSwUKViqlrpRoYN0t1MXJySAiYSBxv
	7WSBsdtvtDCD2GwCGhIHD50Es0UEBCX6H89gBbGZBbwkzu+fCxYXFrCX2PBpHhOIzSKgKvH9
	yx6wOK+AmcT2vjNsEDM1JRou3QOr4RQwkrizZwGYLSTAI/Fqw35GiHpBiZMzn7BAzJeXaN46
	G2gOF1DvQ1aJhZ/XMkIMkpQ4uOIGywRG/llIemYh6VnAyLSKUSgzryw3MTPHRC+jMi+zQi85
	P3cTIzC4ltX+id7B+OlC8CFGAQ5GJR7eEyY7MoRYE8uKK3MPMUpwMCuJ8M7g3ZkhxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnNfoW3mKkEB6YklqdmpqQWoRTJaJgxMYlhlMNSWGspxxFcHszndm
	zzmauXBK+ekY9o8pXSY+fpM4q/J+8wq8UcqN/zFZdVWUNcudSrHamhfnOq1j32VqPQqyTGfS
	vrbhjGfglwlaxySPPrr6J81KyW36jxPvkzpjw76oPJfzdfn2xSAwUXVi5kRHJragXdc2TnZ8
	PV115Q6pK3Wbz4nWKLEUZyQaajEXFScCAJI8POIqAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnluLIzCtJLcpLzFFi42LhmiGro/vHd2eGwZ0/ehZP/v9mtfj87DWz
	xeG5J1ktDn99w+TA4rFpVSebx4vNMxk9vt328Fj84gNTAEsUl01Kak5mWWqRvl0CV8alpqSC
	hSoVU9dKNTBulupi5OSQEDCRaL/RwgxiswloSBw8dBLMFhEQlOh/PIMVxGYW8JI4v38uWFxY
	wF5iw6d5TCA2i4CqxPcve8DivAJmEtv7zrBBzNSUaLh0D6yGU8BI4s6eBWC2kACPxKsN+xkh
	6gUlTs58wgIxX16ieets5gmMPLOQpGYhSS1gZFrFKJKZV5abmJljqlecnVGZl1mhl5yfu4kR
	GDzLav9M3MH45bL7IUYBDkYlHt4TJjsyhFgTy4orcw8xSnAwK4nwzuDdmSHEm5JYWZValB9f
	VJqTWnyIUZqDRUmc1ys8NUFIID2xJDU7NbUgtQgmy8TBCQyoKX8Vc6ROmyXekFX70F82W7a5
	a+3K9cd+Pw7drLPUSuuzPW9AsAKT1Mmpv5UOdpi+eyi8MybuwnldTy+LKSt+5ZsvfV4x3yG6
	3kRJzOzc+c8euhcMqqtmlO7lLjTNvsj1J2lLz47TonwMU+7le1pwFzpJCWvEMbtUles/W7J/
	t4zvj9qk4/lKLMUZiYZazEXFiQA5AGJzGgIAAA==
X-CFilter-Loop: Reflected

On Wed,  3 Sep 2025 21:02:03 -0700 SeongJae Park <sj@kernel.org> wrote:
> Hi Yunjeong,
> 
> On Thu,  4 Sep 2025 10:17:38 +0900 Yunjeong Mun <yunjeong.mun@sk.com> wrote:
> 
> > Hi!
> > 
> > I encountered a kernel crash when running 'damo stop' in kernel v6.17-rc3, 
> > I tested and confirmed that this issue also occurs in v6.17-rc1.
> 
> Thank you for finding and sharing this issue!
> 
> > 
> > 'damo' version that I tested is v2.9.3 and v2.4.7.
> > 
> > The crash happens when DAMON is configured to used both 'migrate_hot' 
> > and migrate_cold' actions. I tested that if DAMON is started with only 
> > one of the two actions, it works fine.
> 
> I understand you mean the problem is reproducible when you use two kdamond
> threads, and you confirmed it doesn't happen when you use single kdamond
> thread.  Please let me know if I'm misunderstanding.
>

Your understanding is correct!

> > Below is the command I used:
> > 
> > ```shell
> > $ ./damo start \
> >  --ops paddr --numa_node 0 --monitoring_intervals 100ms 2s 20s --damos_action migrate_cold 1 \
> >  --ops paddr --numa_node 1 --monitoring_intervals 100ms 2s 20s --damos_action migrate_hot 0 \
> >  --nr_targets 1 1 --nr_schemes 1 1 --nr_ctxs 1 1
> > 
> > $ ps aux | grep kdamond
> > root      1193 98.2  0.0      0     0 ?        R    07:58   0:18 [kdamond.0]
> > root      1194 11.2  0.0      0     0 ?        R    07:58   0:02 [kdamond.1]
> > 
> > # Error occurs
> > $ ./damo stop 
> > ```
> 
> Thank you for sharingthis detailed steps.  On my setup, this doesn't cause
> crash but make 'damo' hang.

I have tested this issue on both a physical server and a QEMU.
On the physical server, both a kernel crash and a 'damo' hang occur.
In the QEMU environment, only the 'damo' hang occurs, without a kernel crash.

> 
> I found commit d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file
> internal work") is the first bad commit, according to 'git bisect'.  And
> actually the code is broken for multiple kdamonds case, since it is sharing one
> damon_call_control object for multiple kdamonds while overwriting the data
> field to later-called one.
>
> I haven't yet deep dive into by what code path the issue happens, but sharing
> this first, since I have to go out soon.  I'll further take a look later.
> Meanwhile, could you please also confirm if it is the first bad commit for your
> issue, too?

Thanks for sharing your analysis!
I also confirmed that first bad commit is d809a7c64ba8.
The previous commit b907494768e5 doesn't cause the above issue.

> 
> > 
> > This issue also occurs when starting DAMON using yaml configuration file 
> > that includes both the 'migrate_hot' and 'migrate_cold' actions.
> > Below is the dmesg log at the time of the issue:
> > 
> > ```
> > [157729.130361] Call Trace:                                                                                                                                                                                                                                                                                                                                                       [19/1810]
> > [157729.130540]  <TASK>
> > [157729.130718]  kthread_stop+0x158/0x190
> > [157729.130904]  kthread_stop_put+0x18/0x80
> > [157729.131084]  damon_stop+0x4c/0xd0
> > [157729.131264]  state_store+0x190/0x380
> > [157729.131445]  ? __x64_sys_ioctl+0x7e/0xf0
> > [157729.131625]  kobj_attr_store+0x13/0x30
> > [157729.131805]  sysfs_kf_write+0x73/0x90
> > [157729.131986]  kernfs_fop_write_iter+0x13a/0x1c0
> > [157729.132167]  vfs_write+0x304/0x420
> > [157729.132349]  ksys_write+0x6d/0xe0
> > [157729.132525]  __x64_sys_write+0x1d/0x30
> > [157729.132696]  x64_sys_call+0x16ec/0x2180
> > [157729.132865]  do_syscall_64+0x74/0x1d0
> > [157729.133030]  ? __x64_sys_ioctl+0x7e/0xf0
> > [157729.133195]  ? x64_sys_call+0x1268/0x2180
> > [157729.133364]  ? do_syscall_64+0xa3/0x1d0
> > [157729.133534]  ? do_syscall_64+0xa3/0x1d0
> > [157729.133698]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> 'scripts/decode_stacktrace.sh' can show which line of what source file each of
> the above line points.  So if you could share the output of the script from
> your next bug reports, it would be pretty helpful.

I'm not aware of this tool, thank you for letting me know!
I'll trying using it next time.

Thanks,
Yunjeong Mun

> 
> So, I'll take further look, but please let me know if the first broken commit I
> found is also the first broken commit for your issue.
> 
> 
> Thanks,
> SJ
> 
> [...]
