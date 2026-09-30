Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE551AFD2
	for <damon@lists.linux.dev>; Wed, 30 Sep 2026 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790199; cv=none; b=Cx4WsTmQcg3XXTNg+/b3IlwGO3ST6U/PnRS0D8kAD/uMEBpz59Bve4jiyPf7G5BmX3AHjXt4nzPj420z3q/Kub9SNEtWSdFEgDCyOJj4asW5rhjgRefJlVM/dcueMEvxQxd+A76di/DkSx4e61yWxfSDDk9zlB5CXO7HVwXDdiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790199; c=relaxed/simple;
	bh=8gKn6EkV4vIpOc/qmqduu9W314kO3+alMIfob4Lzf84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vy9eGWhhvIUhOqRBdfpfRtpkQK6HRFkAjYu2eSno7FihhtVTpgc96qOShkZkoDCyb4PzANpbVAbF/M07hXLq4qtsEMpg/urI+JzsYFkU2280ohiJR9zc7RosjXhZ6JMMx8qp3hBqyz7tt3BDbUkOYqSG4xpO8uCiI8dHSKjYm00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTzJiMFC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTzJiMFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7C01F000FF;
	Wed, 30 Sep 2026 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790790198;
	bh=xTW9Cw+ZcS12jO83YnXP1st5xk5mD5xflpHpBRWXLhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cTzJiMFCXlMtSVTF0o7CZqPCq72Q2YjB3KjJ8OGNYN3Np1u/OveVfqLR7fRWI41I1
	 wvFWMI7QpDBb0wpyDwVtuIFQkBC8G7/BqnnI1R7K2+gdgwB46T+Fp+/zZ08IML/LQj
	 1Y8UuTu3YZvqxfdMTHtHE8H/NW339WyAIJLWopQpHfj3qsUHulXGxwFVyQZ9dPgSpg
	 1ur/YQrWQIO/QRAIfrHT/BrQrvaUz3W8MQ79cqXd+cxlEACEjqQU/FuJi9kyXFusS3
	 EV6Q2qfS4bDniEvIMEtGAwthUZV/+pMRFJfE15mWWTvuk/6xXWZeY9tdOsm1YsErJQ
	 NS5kQorJ018zA==
From: SJ Park <sj@kernel.org>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: Memory tiering with DAMON/DAMOS auto-tuning
Date: Wed, 30 Sep 2026 10:43:13 -0700
Message-ID: <20260930174314.60183-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAAiJnjoaaPk3CcczDtk72xfkrgwp29KDT1==PZJJGgUcBVpdjA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 30 Sep 2026 19:26:31 +0300 Anton Gavriliuk <antosha20xx@gmail.com> wrote:

> I would go back to memory tiering VCF9.1-like behavior you helped me
> configure, for new few questions:
> 
> 1.  It works with the goal of 50% free memory for numa node 0, but
> when I tried to set 25% free memory, it didn't do anything...
> 
> [root@localhost ~]# COLUMNS=500 numastat -p $(pgrep valkey-server) | cat
> 
> Per-node process memory usage (in MBs) for PID 3808 (valkey-server)
>                            Node 0          Node 1          Node 2
>     Node 3           Total
>                   --------------- --------------- ---------------
> --------------- ---------------
> Huge                         0.00            0.00            0.00
>       0.00            0.00
> Heap                         0.11            0.00            0.00
>       0.00            0.11
> Stack                        0.03            0.00            0.00
>       0.00            0.03
> Private                 238356.25            2.19            3.42
>       0.00       238361.86
> ----------------  --------------- --------------- ---------------
> --------------- ---------------
> Total                   238356.39            2.19            3.42
>       0.00       238362.00
> [root@localhost ~]#

So, your workload is using ~232 GiB of node 0 memory and no demotion of it is
occurred.  According to your original mail [1], the node 0 has ~377 GiB memory.
If we make 25% of it free, it means it should have 75% of it (~282 GiB) be
utilized.  If the node0 has only your workload, it means node 0 memory
utilization is still only ~61%.  In other words, 25% free memory goal is
already achieved.  Than DAMON wouldn't do any demotion.

Does the theory makes sense?  Maybe you can confirm by checking the free memory
ratio of node 0.

[...]
> 2. If there are no un-accessed pages to demote for achieving a defined
> goal, damon will demote pages with the most rare access ?

No.  Because you set '--access_rate 0% 0%' for the demotion scheme, it will do
no demotion in the scenario.  You could try '--access_rate 0% max' if you want.
You may also need to remove '--damos_filter reject young' option from the
command if that is really what you want to do.

[1] https://lore.kernel.org/CAAiJnjp5F8ZuPG1gEsD_Wgs7Z+GToz67nzjr0490sz9y328=dg@mail.gmail.com


Thanks,
SJ

[...]
