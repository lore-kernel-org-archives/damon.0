Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1583ECBD2
	for <damon@lists.linux.dev>; Tue, 29 Sep 2026 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671291; cv=pass; b=ZDPeVUdC6QNw2TKxCXTEZz7WW85UbPjW/NSLjCs/5lsKWXQyFHRJkG2mQPAxar784gV6wvDmVSeiTXSC7/9h3gOYRocFxajxAT4epHEDMrNBZ/hO6XNWcIpmYK5nJTNILoabSPMlV9zucoLDhUvsxTz44ROVFz1Q2lxGAMRAJTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671291; c=relaxed/simple;
	bh=p+0XdCGlztUfiUK+du+FchC32D9Laj47pYXra+kbEWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YlQl6fYngCqGGJBQ5dZ6oSaOwUtMYJrVATWXavbChnNPTiB1evfDkCZNS8JkW0UgM4yZ6b17RnurmSFdLt3rRrolUEfZ4GIpt/daUKpV8MzTVfjEaIdVoygRa8Uj8/qXbRpUQq6gkiDHYPsTkW3S5TzRAyU7AaaPDqKN3m6uQY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGPwsqMA; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGPwsqMA"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a996c8adf3so6325736a12.1
        for <damon@lists.linux.dev>; Tue, 29 Sep 2026 01:41:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790671288; cv=none;
        d=google.com; s=arc-20260327;
        b=EmRDWTSHSF/9hOTWjOZ7dnchINEUCHsVCt/U3wAhVfcs5c7KgDqr5wqCAnzW14/Uqu
         ItVsNHNcfwXRkTOvZd1jZmlFWFrdCboH6qk0QoDDvcDcW8sb53BcBBgiP31mJwkGNVsv
         fapocdKsvNuxioKolRleua2x2Yrj6KxUzLXvd6F7Y3KvbOHmUgsJNpUxZV/IEWqqv52i
         jDQ1p50R9f7zcGrMDwyPHzmXrTZMeEx4Z7plYMWO9mvt0Y1HxgD6okM/DzPRuUInCRAr
         fA8sObQjizr8nRBnqIPAitfPzDXyVjNOtZ18X5nx8XX3hi9sqbKhIfGm9/hQ77MwTq6/
         El+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qu//bkRmDd6CGZ3vDJxRK2nokCV0TBfsc32ritsgJks=;
        fh=e+kRStJq+twn6rlp7glLc6kIxtYd+ofNVnbBqiY9oQA=;
        b=E9HO07NDdW+SUMKn+WHZNQMhuoMCKaPMIaItnRKPkBjbPvLSA/PapDghhTNXRgf74C
         IxVEK2/8hWIXEtiiPZORNPQUOj9y+uoIQyI8LBaYUk+NjboMBjCXK1LsPo0FXqZWTRCK
         irZvh/clbsk1A32K5XM/YwTV+gOmnL/qnBkRuHbvMr0z9yZmdWFyIjTuSs/4hu+SqUxc
         rg/fGF/hSH1HjZvm9Xdu8hoJLXHHV3psqUDsx9WFltNMWyfYGvTZb5ChnkT5TH5qnCA0
         V8e82nmF7rynnTHGCqZ0OHJTqE9qxL7ZTrjZdtBp/xz4vBGNT/nSi/VGakhXQ7J10o+t
         FQRg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790671288; x=1791276088; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qu//bkRmDd6CGZ3vDJxRK2nokCV0TBfsc32ritsgJks=;
        b=aGPwsqMAwUVWU4Gk9BgWy/GxLfosWkIttXwgmeRDKwbF+YrUIx/fJSuDxxClg4dMSh
         /NkmijZw9Nk4Y+I07c4K+I3sH0pi2teLRivSzINKcj2TefU8fgrMGBe1G/8x36/3jU+v
         IwgK337j4XAVmHuO0Nn0dmWz1bDcTZCy9/7RKYQe7Spg14siKajE/qLxGfS0RHQNMmWh
         zq7lZCFJK1DTibbB/1HwniCr5bAseVfnKzVWglFgnIPQB8BqT2By5oBlVy4bAdwsdNUV
         7SiotChiOXCjqtpOpGOP0J+B0+xpmbUMMSQYLZ8iLAcGRvKI0k4tiOGEMQNiMyU1scIf
         tfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790671288; x=1791276088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qu//bkRmDd6CGZ3vDJxRK2nokCV0TBfsc32ritsgJks=;
        b=gutWFrThd0hIkAFeQ8RX9fb5eiB+g0AGmJxAuVaps3u8yJx8C80Iy5Y/52qgchHBrx
         PjakYJZ3n+PgPy4TeUGTynJfcxFbHxdovSEvJPk7ShYgnQ/rcF81bWU48f8MwV2z8FWq
         V84bRF3nYEUygNSBlRMOVvFPy+MdQ8hPsjW83Evv7OagxZKnUQ8XAxAHP5cWqvKciFZa
         PzeeajOBBVEh1TYXN3ZQkQt7g1Q0+vBSNpjVCjOtwjODtwhFwO3S79k87EyP8+fh2Etm
         9eHAMCowEUEwM0fVtLxLDlfxQisW0b92XbLHmtDKdzx63OEZx80/N8vV1Tt8RCp/255X
         rS6A==
X-Gm-Message-State: AFq9FYLoYyTSS1+sCqtoD8H1sFDa4MT5PnFtfJuzxD/dSmZN3PHPaByT
	q7mIIKBI5iQPGjaq9pO3Yy4eDS38qi2YNC2QTfsqYrQa2ZF/+rSjuuyvA+qm7ZqppTHXX0BxUnh
	pWb0PTcmn4RRcx33xFrADw8fXgBnIHJM+FTvZ
X-Gm-Gg: AYBFou18ttEBb/QUHN6lC1whISHcwWEH9tQkhHrj4rwt5+iOXr2TMJvwBjY3UmNiqT/
	x3shLsU48FkeNV604QJ8vi7zhp1vGfe64vIvNIKrwtzCga/dNvA3e8Om4WL4lA8faRnC9Nstbbr
	TOBUKlavhiq8t95Bksrywm8v6oort9WVga884GHLd3ElR+Q7BX0bNbIIUNy0aUB7PMOWZHmiWd+
	xdzOdIbimFhD8m5A/th/zUheTq8L4d4SJkjCfM2Js/rCGKnOW5xXL5M18UK0LDAkZYd1JVWvuoZ
	noC7Hnt5k44sAAV8VtJG/ZU1EfnfUEEBjyKDSvzJyE6MdBc+Fd9NZLwPzXb30fcc4Yg=
X-Received: by 2002:a05:6402:c212:b0:6aa:e589:87de with SMTP id
 4fb4d7f45d1cf-6aae5898986mr6690234a12.20.1790671287640; Tue, 29 Sep 2026
 01:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAiJnjrJxoKy3AdXHiCSEGZyDwSqDJa4riO5FZeQX9uZKfjgmg@mail.gmail.com>
 <20260929074932.40176-1-sj@kernel.org>
In-Reply-To: <20260929074932.40176-1-sj@kernel.org>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Tue, 29 Sep 2026 11:41:15 +0300
X-Gm-Features: AclHuK-xnSnwX5_WlKoj0m48alPE2uOpW_7IVlxcxIH-nseJepj12X4wub4cFso
Message-ID: <CAAiJnjo1JJAJ_Cu0FEZ5kxRaEEt9yqyGrJJq8ottwg=bNFo3rQ@mail.gmail.com>
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello

I decided to move step-by-step, so firstly I would get on Linux/bare
metal or non-VmWare setup memory tiering behaviour like on VmWare 9.1
- https://knowledge.broadcom.com/external/article/449016/understanding-nvme=
-memory-tiering-activa.html#:~:text=3DCause.%20This%20behavior%20is%20by%20=
design.%20The,page%20activity%20based%20on%20recency%20and%20frequency.

"Threshold Activation: The VMkernel initiates memory tiering only when
total host physical DRAM (Tier 0) consumption reaches approximately
the 80% threshold. If consumption is below this trigger (e.g., at
70-75%), the system will not migrate pages to Tier 1.
Page Classification: ESXi monitors page activity based on recency and
frequency. Only memory pages strictly classified as "cold" (inactive)
are migrated to the NVMe Tier 1 device. The active working set ("hot"
pages) is deliberately retained in Tier 0 to prevent performance
penalties.
Scan Rate: The page scan and migration rate scale with memory
pressure. At lower consumption levels (just crossing the 80% mark),
the rate is highly conservative."

Here is my corrected command,

damo start \--numa_node 0 --monitoring_intervals_goal 5% 3 5ms 10s
\--damos_action migrate_cold 2 --damos_access_rate 0% 0%
\--damos_apply_interval 1s \--damos_quota_interval 1s
--damos_quota_space 8GB \--damos_quota_goal node_mem_free_bp 50% 0
\--damos_filter reject young \--numa_node 2
--monitoring_intervals_goal 5% 3 5ms 10s \--damos_action migrate_hot 0
--damos_access_rate 5% max \--damos_apply_interval 1s
\--damos_quota_interval 1s --damos_quota_space 8GB \--damos_quota_goal
node_mem_used_bp 50.3% 0 \--damos_filter allow young
\--damos_nr_quota_goals 1 1 --damos_nr_filters 1 1 \--nr_targets 1 1
--nr_schemes 1 1 --nr_ctxs 1 1

with consist -> temporal,

[root@localhost ~]# cat
/sys/kernel/mm/damon/admin/kdamonds/0/contexts/0/schemes/0/quotas/goal_tune=
r
temporal
[root@localhost ~]# cat
/sys/kernel/mm/damon/admin/kdamonds/1/contexts/0/schemes/0/quotas/goal_tune=
r
temporal

But it again didn't stop ~50%

[root@localhost ~]# numastat -p $(pgrep valkey-server)

Per-node process memory usage (in MBs) for PID 18036 (valkey-server)
                           Node 0          Node 1          Node 2
                  --------------- --------------- ---------------
Huge                         0.00            0.00            0.00
Heap                         0.11            0.00            0.00
Stack                        0.03            0.00            0.00
Private                 228807.54            0.48          185.79
----------------  --------------- --------------- ---------------
Total                   228807.67            0.48          185.79

                           Node 3           Total
                  --------------- ---------------
Huge                         0.00            0.00
Heap                         0.00            0.11
Stack                        0.00            0.03
Private                      0.00       228993.80
----------------  --------------- ---------------
Total                        0.00       228993.94


[root@localhost ~]# numastat -p $(pgrep valkey-server)

Per-node process memory usage (in MBs) for PID 18036 (valkey-server)
                           Node 0          Node 1          Node 2
                  --------------- --------------- ---------------
Huge                         0.00            0.00            0.00
Heap                         0.01            0.00            0.10
Stack                        0.01            0.00            0.02
Private                  13434.01            0.48       215559.31
----------------  --------------- --------------- ---------------
Total                    13434.03            0.48       215559.43

                           Node 3           Total
                  --------------- ---------------
Huge                         0.00            0.00
Heap                         0.00            0.11
Stack                        0.00            0.03
Private                      0.00       228993.80
----------------  --------------- ---------------
Total                        0.00       228993.94



> > Oohhh... I moved to 5%.
> I understand you mean 4%?

As far as I understood, this value represents "accuracy", so there
shouldn't be a big difference between 4% vs 5%.  Or please correct me
if I'm wrong.

Anton


=D0=B2=D1=82, 29 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 10:4=
9, SJ Park <sj@kernel.org>:
>
> On Mon, 28 Sep 2026 20:02:43 +0300 Anton Gavriliuk <antosha20xx@gmail.com=
> wrote:
>
> > > Thank you for sharing your use case and question!
> >
> > Thank you for your quick response and your answer/comments.
> >
> > We already had memory tiering implemented at hardware level 5-7 years
> > ago with Intel's Optane PEM when configured in Memory Mode.
> > Now we do the same thing at Linux level :-)
>
> Interesting!
>
> > I'm new at DAMON/DAMOS, there are lots of new tunables to me.
>
> Indeed there are.  I'd recommend starting with existing DAMON-based memor=
y
> tiering solutions including SK Hynix HMSDK and my auto-tune based memory
> tiering script [1] and ask questions to the authors.
>
> >
> > > The example memory tiering script [1] uses 4% as intervals goal.  Is =
there a
> > > reason to use 97% as the goal instead?
> >
> > Oohhh... I moved to 5%.
>
> I understand you mean 4%?
>
> >
> > > Is the above node_mum_used_bp what you really want?  That means you w=
ant to
> > > promote hot pages from node 2 to node 0, until the node 0 memory util=
ization
> > > becomes 99.7%.  That overlaps with the demotion goal (50% free memory=
 of node
> > > 0) quite a lot.  I'd suggest smaller overlap, say, 50.3%, to keep hea=
lthy
> > > circulation of hot/cold pages while not consuming too much resource u=
nder
> > > stabilized access pattern.
> >
> > > DAMOS quota auto-tuning supports two tuner algorithms [2], consistent=
 and
> > > temporal.  As the documentation [2] explains, 'consistent' tuner assu=
mes it
> > > should keep applying the action in a level to keep the goal achieved.=
  In this
> > > case, for example, the demotion scheme assumes there will be continue=
d
> > > promotion and therefore it keeps demoting.  If there is no appropriat=
e
> > > promotion, it could result in demoting more than expected amount.
> >
> > So let me firstly understand what I really want to test :-)
>
> Sure, and please feel free to ask any question in any ways.  If you prefe=
r to,
> you could also ask questions privately to me or use DAMON Beer/Coffee/Tea=
 Chat
> series [2].
>
> [1] https://github.com/damonitor/damo/blob/next/scripts/mem_tier.sh
> [2] https://docs.google.com/document/d/1v43Kcj3ly4CYqmAkMaZzLiM2GEnWfgdGb=
ZAH3mi2vpM/edit?usp=3Dsharing
>
>
> Thanks,
> SJ
>
> [...]
