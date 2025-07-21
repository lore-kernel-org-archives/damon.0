Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFAE2DEA9E
	for <damon@lists.linux.dev>; Mon, 21 Jul 2025 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111713; cv=none; b=t9TUttSmmOdOYQ5EcBqyAgmYZQ6dBcPod6vBBLMWe24pmI4Lw+PFXhqu5cyVaVZfdUcWTr9Olzo7dqtpIyBJF9KOYN5MBTIb3IRC5ligKixhjoTmspNEJdFCEkKy18YRWfsyvBhVMQSh3ElUDn88QRZbb38XWaWDsWXE8TwpxVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111713; c=relaxed/simple;
	bh=0x7AlFf/zSQtyGfrxywbD+ZCXfFBkFZceiIJvgJFwgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPdA/Y0NfHLWvimyQ0mUSshBSONAZoHy/Q35/9JJSG/2PL9pYshSu9KyWKOtvV65NzUadC1cRmtOYa+ru5QPmFkb3YuyeEl2fGS79CYGEXpp67+6Voqq4F0JpyJV1m59J19vo6IpPvav3wKIUDUMwjx58hMKrBDsVLZGr4Ehx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5HmMbLP; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5HmMbLP"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8c475ecd5bso3633501276.1
        for <damon@lists.linux.dev>; Mon, 21 Jul 2025 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753111710; x=1753716510; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxyUby716vtNBhVOSKlP2j4uEXJ9sXitnuotbZdiw0Q=;
        b=g5HmMbLPqwx036i/ngPo5NzPYNuWTfOowF2mYFNLd18hn+r7g7PTOBH0rWQFNW2ZIC
         /CRvzCbpu8Jqx9vJW22u/HoBin9fscakmt7006flKNkCSbC9pta31CtgP2FL9R0saOw0
         j+04Fsry/9VbAuJBvQ+uSlBW2s2z94Pxw0cLR5QY7k+BnRgZLOWBnV4RZT0L4n25NFw9
         jIdgj34wVGGdVgGeoIru5+SeK5Tp0xPgoW+PqCRgeLOZI7kn1WiYdUrxB4pPcoT4J4hQ
         fXN2V2ZSWB13WhJ+NyjtvXWDF0v9Z/ItPkQswHfORRzEO2AEeAY+70o6Ge8WRwt7NoWD
         mr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753111710; x=1753716510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxyUby716vtNBhVOSKlP2j4uEXJ9sXitnuotbZdiw0Q=;
        b=YtmKP2KinWtXVuO7cVIJjGrqbwFEyBZkAIaYlVrbhvYBDlSCaWCYD/g/2/ZsNIgaXN
         ZNYY1Ktz1hJLx0XK3WF+ljrFx03AqUZHbGsba59Ow3atmNj52oMEbegnNbAMVjD8gRWe
         q/RS0fzwhl++3KPAqS9XAlrb7k3rHs1eWsvR8c0AmzuVrCnKROW64yHG8lEOskUBvT+/
         70pMxXt9qOmQQdxV1nQsR1BQIY2vgIIgcZLz4wv5X/jlm5MWKgVCeRRX49J4hEszcVAH
         tfV39tLhpJX4lphhmwBoIrYC86R7FWOfJYBF2PIROqHwFwq03/gWeR3UYbOY61NmIU9g
         VwdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzxcf9I5IZG/WL/0xPqXMbQ0n2h83JpV3o+W7t8yMA0WVyxEbTJfyME8biq03FSmki12YzRg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+7tDkZfBojQm8TvWB36e5yN7UclQ/mDznk/NtnBVdTHcEzqDO
	NBGwClEb9lrY4P0bqi43WDdcZvRcTFw4/SouH64wVF/DF1NHQHC1YFot
X-Gm-Gg: ASbGncsy6fIHO5Kus0XO2tzZzdNSZK4HZz5bAOUWtCIQz2T4IoOlJcNlbhxmqSj6rzm
	MoS5d2AqX4hBUao0fBkHrH99t6MpMcDV4V+crfuW1Jm0HQ/t/KXuqWJWEgqI9VxD5nV9pBgIOrV
	3qw8RNM48A1woo4Bzuze6ky5Syz3tg3Ql0RaEiIH1d+AGZ3YvdGfyBjtR/7z79fjzTCwxTFF60K
	mTE2EzVv4pihBJR7QhmAu4IgTdWvRGGWCW3JRCvSJ0NOEA6mSw2ZuSBvUk5JVUkLhXbsZdXddbJ
	y+bGAo4ovLuHyV8hme9Z9wdNbgdcbCdzKZdnz7wfBsVIRqfPG8iStPjw4DAxNiAu0KLZMPdUYrR
	0sCzUoKZP9ik7tjZnYZ8+
X-Google-Smtp-Source: AGHT+IF1Fnu/+9zJWEVuDvvjuUAk+1v5Dd7E8Vm/Bkak4K3NtI4w/E/dbUzbbpXxhKawIOb0SvkmeA==
X-Received: by 2002:a05:690c:a08e:20b0:719:6b98:c2eb with SMTP id 00721157ae682-7196b98c619mr71944077b3.8.1753111709979;
        Mon, 21 Jul 2025 08:28:29 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8d7cc39897sm2554397276.14.2025.07.21.08.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 08:28:29 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Honggyu Kim <honggyu.kim@sk.com>,
	Hyeongtak Ji <hyeongtak.ji@sk.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/ops-common: ignore migration request to invalid nodes
Date: Mon, 21 Jul 2025 08:28:26 -0700
Message-ID: <20250721152828.423605-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250720185822.1451-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Jul 2025 11:58:22 -0700 SeongJae Park <sj@kernel.org> wrote:

> damon_migrate_pages() try migration even if the target node is invalid.
> If users mistakenly make such invalid requests via
> DAMOS_MIGRATE_{HOT,COLD} action, below kernel BUG can happen.
> 
>     [ 7831.883495] BUG: unable to handle page fault for address: 0000000000001f48
>     [ 7831.884160] #PF: supervisor read access in kernel mode
>     [ 7831.884681] #PF: error_code(0x0000) - not-present page
>     [ 7831.885203] PGD 0 P4D 0
>     [ 7831.885468] Oops: Oops: 0000 [#1] SMP PTI
>     [ 7831.885852] CPU: 31 UID: 0 PID: 94202 Comm: kdamond.0 Not tainted 6.16.0-rc5-mm-new-damon+ #93 PREEMPT(voluntary)
>     [ 7831.886913] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-4.el9 04/01/2014
>     [ 7831.887777] RIP: 0010:__alloc_frozen_pages_noprof (include/linux/mmzone.h:1724 include/linux/mmzone.h:1750 mm/page_alloc.c:4936 mm/page_alloc.c:5137)
>     [...]
>     [ 7831.895953] Call Trace:
>     [ 7831.896195]  <TASK>
>     [ 7831.896397] __folio_alloc_noprof (mm/page_alloc.c:5183 mm/page_alloc.c:5192)
>     [ 7831.896787] migrate_pages_batch (mm/migrate.c:1189 mm/migrate.c:1851)
>     [ 7831.897228] ? __pfx_alloc_migration_target (mm/migrate.c:2137)
>     [ 7831.897735] migrate_pages (mm/migrate.c:2078)
>     [ 7831.898141] ? __pfx_alloc_migration_target (mm/migrate.c:2137)
>     [ 7831.898664] damon_migrate_folio_list (mm/damon/ops-common.c:321 mm/damon/ops-common.c:354)
>     [ 7831.899140] damon_migrate_pages (mm/damon/ops-common.c:405)
>     [...]
> 
> Add a target node validity check in damon_migrate_pages().  The validity
> check is stolen from that of do_pages_move(), which is being used for
> move_pages() system call.
> 
> Fixes: b51820ebea65 ("mm/damon/paddr: introduce DAMOS_MIGRATE_COLD action for demotion") # 6.11.x
> Cc: stable@vger.kernel.org
> Cc: Honggyu Kim <honggyu.kim@sk.com>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---

LGTM, thank you SJ!

On a side note... This seems like it would be a common check. However, doing a
(quick) search seems to return no function that checks whether a node is valid.
Perhaps it would make sense to look deeper and see how many other functions
make this check, and export this as a function? I can try spinning something
if it makes sense to you : -)

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Sent using hkml (https://github.com/sjp38/hackermail)
