Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928EE442FAE
	for <damon@lists.linux.dev>; Thu,  1 Oct 2026 09:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848734; cv=pass; b=pgieyjsJ0xyz8WhHhozIS3vthgiyASQQAbqtFbhwLDRqcaKvePQ6baF8aTlXqtykJBJvh8NNxSuo4v6A2gfzCt4bEn/c7NhgpWkmgAGhv/cAdnWWmAAvxpur0cNFvPmsi4H/qTgzKGrhlSnRvfn/lStlOzvO8aDeE95CYKhcvpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848734; c=relaxed/simple;
	bh=haxDshANFQOJCeOUeegZZTb/1bt9tNaJwZPsDyZu224=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJxBraVrtCfCJjSfnBadTGcuN51cSTMJfGj0Y+KKfpuh34qVlGjC4oP9KEtOo9HMYHnA+81EYZXDu9+rgW3+sDGiu5H+vuDppSYHst7z5VrCEUnYFmdmIHVPcSyGvLa8qd27WBDVq+ttCP2AKF5zhCiIS5mTwKOrzp4If+y95JI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5oP1l96; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5oP1l96"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acbdf627ccso3354419a12.2
        for <damon@lists.linux.dev>; Thu, 01 Oct 2026 02:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790848730; cv=none;
        d=google.com; s=arc-20260327;
        b=j/aloO6VI+3YQlB4wXqUO7Epzcm0SelSi/9Q/ynx0AEo/EZO2uubQketZ+DurUlKAK
         BGpBYCcIxycOdGy0l0hv0cEsjI+W4UTHZX9LkIFH7qRfx1pykZH2DYNzBVHlZD6Nv7NB
         33TQmLVBYFmIWo6zEH6PBuvToFqg5gBMyj2yR02GO/OHvw6MQCpqAuATNcUyjUif8RI7
         8QChTF1hv2Wbi5E3IzEv3cd0lJqzuroESsZUIgDGTdafkoMTKpyrGpjBkss1PVYjWV0B
         EcO47e3Swtt4toXLN+lrPl+3BBfnSmm84qpCwNoTW22vXn8acyIiJnp/x03+YKrtVTKS
         p8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UCRAKD4GPViS9WZk0pEH6e3kj0OPF85J7GqXdLb4FxQ=;
        fh=e+kRStJq+twn6rlp7glLc6kIxtYd+ofNVnbBqiY9oQA=;
        b=o0TegP7tazfKXGmwiDJzFJEsmTVOtBOjXk5BxLwQ/QWY/h34LjCkmy2WCbXHUJpiq6
         Eq0gKSTf4nDtnyQSspO+1WJIQsF6I1smohxfu6H6I2qpD5sqHz9dk3LMsBcTVxob6XXt
         Za88HHD+aMbojwljP1U8fsiv9IK1tRlNVCfi+UiNaaPZZuoJUYoySAPp2bmJpRYKOl/H
         +b/yHbwErCGt/RC3YKDZBuqoSBnU9sE/827+y3La6el6sj2xQbMmuIZZPU2I4HNdwjCR
         mlrVgBNsOGTIulHs/AxkN13l894DHM2OyHrjXWFkpW+erVdC5pANVlmId/sIQfZGKaiC
         H4vQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790848730; x=1791453530; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UCRAKD4GPViS9WZk0pEH6e3kj0OPF85J7GqXdLb4FxQ=;
        b=B5oP1l96CzAjIPe7Ns0V3eGhAgQEj73rj6ThnSuOKIQ+QyNkQpux+MYoCJ0eJAWdJb
         n1GwTUDKujePre/BL20qaMTfyRqwz0C1F/dr4758/F3+KcnLYmzGSL9Xf5yarnZaLxTD
         x2xT7quoajxgYVjextzLjQg1ebfuVMPtZsx+nUwALmwlp9dLxZ0kAaAktI28W/j4u3KF
         9YhaF3b8WKHrnMozCI0opkb77NiIgpots9PE5l1pBUzLZVdKSb7EYBzt7MwP9dapSZit
         ww4bD97GYnGNS4xWA2Ic+GGounCbc5OKhwCM2Qv277VXsNS5KMJT3iUCAWs0xt1UFHq7
         6CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790848730; x=1791453530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCRAKD4GPViS9WZk0pEH6e3kj0OPF85J7GqXdLb4FxQ=;
        b=Iha/wayoydUw63ZslBj8cZp027tPBm4r7H/F5wO8H2Kst7IR+rzdpLSopSp6pQUq2o
         wVka3x5hb4hfeLS00TrbnnajO1ZJIxE5EF4Ts0hwc8eMnVkw5L/3EI4tuQslvUUI5/Tu
         uRJzE0ixfFkqutcsi/Q3bMYZ95YLz7ahqC98XB9LdWllKHBQuQ9PNAjPnVHo2cfsXUj3
         s/sM5ZzR0H5ZUemMSVbPZsfBhjmM/YGb6Mgtql/olfF4XaBXNJEEAj78nVtXXFUNH6Rz
         93Iei6u1bWCIb21yu8Xp+tFESrW+50AOphBxhldNC05j/xEr+Xgrwmmql+/QHMgpa9k3
         NMLA==
X-Gm-Message-State: AFq9FYIxOUiZ26CRELcd+Bq/7ej3LP3m8L9hZyIncGtTkBdq33DppZgH
	htxC09YSWXMGevPAeLsc9ob8hEeeNdTIfIqzrpjuvkqP+AeVRVDQFeQsGN//Vo9EbdcRsOR6Cl9
	fo/SadZXIQtua7+NuWFUzw+aMppjAO0C0gQJp
X-Gm-Gg: AYBFou2cNGkz3mIlnTRJmWd6pEW8t48f5PYciEkDWPqlJ3mrYXzlIrAMn4NcWImo3HX
	zHSSRjAuN07rYuYdfFdhJJ2x1CUVo4hTIiMriPoD7lnRQPxIp40ARe3RmQkAGDxsPh5fjP++A2G
	vMG3mVn/mzLG5I8WijHOIP6kxcqGMcVYc0nIOmrH7fsT5AJISdDx9sT2lKbYAQZEPs94p2St5k1
	BtIxEludKHI8uqKAPiZzR6m2R1UHPcUGzKc8RGg75pWdw0LJMlYS2GBcxTNQdZzD8nP/2nuq+k8
	m+PhMPc30qi4RwYqlQ9ghiJtazHowoAX/yCxtUc9QUGZarq/AqZsWoHJ7zOSxQYw0Y0=
X-Received: by 2002:a05:6402:3896:b0:6ac:5e42:5b45 with SMTP id
 4fb4d7f45d1cf-6ae1993bc25mr3005861a12.34.1790848729775; Thu, 01 Oct 2026
 02:58:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAAiJnjoaaPk3CcczDtk72xfkrgwp29KDT1==PZJJGgUcBVpdjA@mail.gmail.com>
 <20260930174314.60183-1-sj@kernel.org>
In-Reply-To: <20260930174314.60183-1-sj@kernel.org>
From: Anton Gavriliuk <antosha20xx@gmail.com>
Date: Thu, 1 Oct 2026 12:58:39 +0300
X-Gm-Features: AclHuK-d8gD3SIyXKEUf18dqnGWiAqjSiRZuQNbS5nlsBPMW3v6fy0CzENPIiY0
Message-ID: <CAAiJnjpkSvWFu1018-wmOn963u8kjrzTWgG=NERQ3RudG1di3w@mail.gmail.com>
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
To: SJ Park <sj@kernel.org>
Cc: damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> So, your workload is using ~232 GiB of node 0 memory and no demotion of i=
t is
> occurred.  According to your original mail [1], the node 0 has ~377 GiB m=
emory.
> If we make 25% of it free, it means it should have 75% of it (~282 GiB) b=
e
> utilized.  If the node0 has only your workload, it means node 0 memory
> utilization is still only ~61%.  In other words, 25% free memory goal is
> already achieved.  Than DAMON wouldn't do any demotion.

OMG.... what was pretty easy.
I feel ashamed.  My apologies.

I increased Valkey memory allocation to 300 GB and it works.

> No.  Because you set '--access_rate 0% 0%' for the demotion scheme, it wi=
ll do
> no demotion in the scenario.  You could try '--access_rate 0% max' if you=
 want.
> You may also need to remove '--damos_filter reject young' option from the
> command if that is really what you want to do.

'--access_rate 0% max' means range 0% - 100% ?
If yes, then I need memory management decisions based on criteria
other than access frequency.
Age-based filters or something else.

The idea is for achieving a defined goal - keep 25% free for new hot
allocations in the fastest tier, if there are no un-accessed pages,
then start demoting the most-rare access or add aga-based filters.
Complicated but interesting, I need to think more about that.

Anton

=D1=81=D1=80, 30 =D1=81=D0=B5=D0=BD=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 20:4=
3, SJ Park <sj@kernel.org>:
>
> On Wed, 30 Sep 2026 19:26:31 +0300 Anton Gavriliuk <antosha20xx@gmail.com=
> wrote:
>
> > I would go back to memory tiering VCF9.1-like behavior you helped me
> > configure, for new few questions:
> >
> > 1.  It works with the goal of 50% free memory for numa node 0, but
> > when I tried to set 25% free memory, it didn't do anything...
> >
> > [root@localhost ~]# COLUMNS=3D500 numastat -p $(pgrep valkey-server) | =
cat
> >
> > Per-node process memory usage (in MBs) for PID 3808 (valkey-server)
> >                            Node 0          Node 1          Node 2
> >     Node 3           Total
> >                   --------------- --------------- ---------------
> > --------------- ---------------
> > Huge                         0.00            0.00            0.00
> >       0.00            0.00
> > Heap                         0.11            0.00            0.00
> >       0.00            0.11
> > Stack                        0.03            0.00            0.00
> >       0.00            0.03
> > Private                 238356.25            2.19            3.42
> >       0.00       238361.86
> > ----------------  --------------- --------------- ---------------
> > --------------- ---------------
> > Total                   238356.39            2.19            3.42
> >       0.00       238362.00
> > [root@localhost ~]#
>
> So, your workload is using ~232 GiB of node 0 memory and no demotion of i=
t is
> occurred.  According to your original mail [1], the node 0 has ~377 GiB m=
emory.
> If we make 25% of it free, it means it should have 75% of it (~282 GiB) b=
e
> utilized.  If the node0 has only your workload, it means node 0 memory
> utilization is still only ~61%.  In other words, 25% free memory goal is
> already achieved.  Than DAMON wouldn't do any demotion.
>
> Does the theory makes sense?  Maybe you can confirm by checking the free =
memory
> ratio of node 0.
>
> [...]
> > 2. If there are no un-accessed pages to demote for achieving a defined
> > goal, damon will demote pages with the most rare access ?
>
> No.  Because you set '--access_rate 0% 0%' for the demotion scheme, it wi=
ll do
> no demotion in the scenario.  You could try '--access_rate 0% max' if you=
 want.
> You may also need to remove '--damos_filter reject young' option from the
> command if that is really what you want to do.
>
> [1] https://lore.kernel.org/CAAiJnjp5F8ZuPG1gEsD_Wgs7Z+GToz67nzjr0490sz9y=
328=3Ddg@mail.gmail.com
>
>
> Thanks,
> SJ
>
> [...]
