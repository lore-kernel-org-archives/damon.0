Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BB928D8E9
	for <damon@lists.linux.dev>; Sat, 16 Aug 2025 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755363524; cv=none; b=H3sEpSKBiV5KYEmXe2DSrcGZjEnv0gIbgnU6q2hz/EAjRJZlKFVlPwOtvRHc7S2mjtEUrzrizevoPmjb5NTEaGULvLJKMb+8J5ty+SCyni4WJXrV1Rludwr+ze5c5B0nnpD/b2yzCSgflvrntj8x6zIeKeBaFrAYufwmJleOKlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755363524; c=relaxed/simple;
	bh=JaYi9Xr8L4RojqQkyKVWSlgoI556UgGfQDDkgebQ89k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BwTCafANH0EqjsrwjFCUjMSCly9vPl6ZKgxfJqZ92QLy1LeCGp3wjLmswQN8SmBE4n8CwqVzRsOjpMMMHNDyptPFDxgo3uM253JtNsPAAAIUxhrb2CuyC/MmMUET61/SyrxrQVdikD6cqildyOvDd/jAgfrW5maJlq9h+m320t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2najJl/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2najJl/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADB2C4CEEF;
	Sat, 16 Aug 2025 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755363524;
	bh=JaYi9Xr8L4RojqQkyKVWSlgoI556UgGfQDDkgebQ89k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m2najJl/UvubQN8BVz2zz1T45AahDFJnLf7hxZxHqaTp0F+Sb0OQo0N9ksOXr1MFQ
	 ToZopb6xoKhiYrMRSqEc6Mvnvr2m1QqWCMhU1zR6G3gaO7T/Z1kwrwQcSSM22I+bhp
	 N1oAOAR56vo3SYIOyyJthnIh2qvIbZAyKPfgXMO8xmrR3HZQaSsebYld7a5Utml8kV
	 pyLwnhBFm1Rm3KN0+K3GCbugopgCOHOQdYt1ATsouHw+3RorNzvvtUDe4Ehlkh2N2g
	 ZdUnZJXvK12lVOeXy93h+aGwQcTf1SkTxBB4b1N06/W65JQDoSjLrymRlHD0kdwRlS
	 cA4Uln+hAwkYA==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	damon@lists.linux.dev,
	Bijan Tabatabai <bijan311@gmail.com>
Subject: Re: BUG while running damon kselftest on 6.17-rc1
Date: Sat, 16 Aug 2025 09:58:41 -0700
Message-Id: <20250816165841.2669-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250816162604.66093-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 16 Aug 2025 09:26:04 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Alexandre,
> 
> On Sat, 16 Aug 2025 17:12:34 +0200 Alexandre Ghiti <alex@ghiti.fr> wrote:
> 
> > Hi,
> > 
> > I'm encountering the following BUG while running the kselftest damon:
[...]
> > I bisected to commit 2cd0bf85a203 ("mm/damon/sysfs-schemes: implement 
> > DAMOS action destinations directory") but obviously that won't help :) 
> > 0x6b6b6b6b6b6b6b6b pattern points to a user-after-free error that I 
> > haven't been able to identify at first sight.
> 
> Thank you so much for reporting this!
> 
> > 
> > I'm attaching my riscv config, hopefully that will help.
> 
> As you mentioned, seems there is an obvious use-after-free bug.  Could you
> please try below fix and let me know if it makes the problem disappear?
> 
> diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
> index 19ec063aef77..138372201981 100644
> --- a/mm/damon/sysfs-schemes.c
> +++ b/mm/damon/sysfs-schemes.c
> @@ -2218,8 +2218,8 @@ static void damon_sysfs_scheme_rm_dirs(struct damon_sysfs_scheme *scheme)
>  {
>         damon_sysfs_access_pattern_rm_dirs(scheme->access_pattern);
>         kobject_put(&scheme->access_pattern->kobj);
> -       kobject_put(&scheme->dests->kobj);
>         damos_sysfs_dests_rm_dirs(scheme->dests);
> +       kobject_put(&scheme->dests->kobj);
>         damon_sysfs_quotas_rm_dirs(scheme->quotas);
>         kobject_put(&scheme->quotas->kobj);
>         kobject_put(&scheme->watermarks->kobj);

I was able to reproduce the issue on my test machine, by enabling KASAN ans
below.  And I confirmed the above fix makes it disappears.  So sent it as a
patch[1], with Reported-by: and Closes: tags for this report.

    [   44.163640] ==================================================================
    [   44.164315] BUG: KASAN: slab-use-after-free in damon_sysfs_schemes_rm_dirs+0xa75/0xc70
    [   44.165116] Read of size 8 at addr ffff888163d94040 by task sysfs.sh/904
    
    [   44.165941] CPU: 38 UID: 0 PID: 904 Comm: sysfs.sh Not tainted 6.17.0-rc1-mm-new-damon+ #3 PREEMPT(voluntary)
    [   44.165946] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.el9 04/01/2014
    [   44.165948] Call Trace:
    [   44.165951]  <TASK>
    [   44.165952]  dump_stack_lvl+0x60/0x80
    [   44.165961]  print_report+0xce/0x610
    [   44.165968]  ? damon_sysfs_schemes_rm_dirs+0xa75/0xc70
    [   44.165971]  kasan_report+0xca/0x100
    [   44.165975]  ? damon_sysfs_schemes_rm_dirs+0xa75/0xc70
    [   44.165979]  damon_sysfs_schemes_rm_dirs+0xa75/0xc70
    [   44.165982]  ? __pfx_mutex_trylock+0x10/0x10
    [   44.165986]  ? __pfx_kstrtoint+0x10/0x10
    [   44.165994]  nr_schemes_store+0xcf/0x15b0

[1] https://lore.kernel.org/20250816165559.2601-1-sj@kernel.org


Thanks,
SJ

[...]
