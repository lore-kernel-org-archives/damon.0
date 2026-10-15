Received: from mail-oi2-f8.google.com (mail-oi2-f8.google.com [74.125.231.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205EE50276A
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.200
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063363; cv=pass; b=JD54afADs3unolR4efZADIEmH2VG4PdW/w6EJLkkOSRm83JzAf11eu/9WVBRzHTgvfp/cFI4cmAHi4NwcVUdJh62Lq696+Y4MvSr+xThMplUmp1IcqlFys8SH00Uxnbc1jy/VomCopvvXvmTlVrDtOBDA8RmD3JSLYt61bfihMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063363; c=relaxed/simple;
	bh=4ronku3FgG/grdupmxyuT7bUinJ8usDzhzYo0Yc2sn4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=WxHj3ZWtRvzJd/73xeAdxlTmJdBvaDrPTt++052ORqD8xD2WJuTfiSyFM7WzOUyzpPbT+nVCYq+hRMFWTVs7VwcIgKFd2O8mY7/pskv1lDriyotXQupG6lYC7/WdtsOyYCioU3c8SZzzLDpFS2mm9SBVgcHInmmnR/2OCtrI40U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdeCHXRj; arc=pass smtp.client-ip=74.125.231.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdeCHXRj"
Received: by mail-oi2-f8.google.com with SMTP id 5614622812f47-51cddc2451aso1404488b6e.0
        for <damon@lists.linux.dev>; Thu, 15 Oct 2026 04:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792063358; cv=none;
        d=google.com; s=arc-20260327;
        b=etJbnB7OfdshmLSVjfwUh5sGdrL4yrAjneVno9B/GgwoOBVfGXq2YXD/P3hRpQrTcL
         el9ghLHQFPhhtgheDXZnJCnf2SBlLhfJ8O++ePXCuWJmi1oxpQafmT7FVj4U15BVm47p
         LM6IdqWIStRINEuCAX5hodSQMHgP0PeMCGqUhKmqVmpKiAoS/b8i4FvRNnhJqeUYI/tf
         OyBLwmGPD/y+a7gCHCC10bdFNC0yfmDYEflGhLlUN3ci4Z2H5ywf4Sf+r/uHqdOGLe4c
         zK7NvM61TDqReCgpwQ5m4EK73nWM2YQjSZOXTm2WJJnwzk4TLdaVcneCO+gdMx6zS9Jy
         /hLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+KhDh+DCKXNAlBFw3mfZ5XMbYKVN/XAmTIjiDnW60pk=;
        fh=GXlUB2kcEueA+23DXXpYOmssRpFH/i7RLbj9yljirdk=;
        b=XfsK1oFtMiotBJK7rAoRyWDcFr9swkkwYYtrsYCgRriolRtoD3/GYhrXfwIC/ADfMv
         mJi6SOcNWoX+J8Ww7Obl/a1Jpt1qiZtUkwnSRBxLDhOzwNFv+wP6qr18OYTymEIsO9rM
         4I/3gNSWnP9qNgJWV5mg6oKPJnOzdviibR3Y4qdpJ2byUv6ugJCf/Y9pAcmP7F1MnR1I
         Tq5IdT5j+cgKqOdP2tqcgdJuSwVFm3vIJeFZOtxhPxfmWGw7alVDILAeXj4ngKU/lsA7
         RGMyaScD8ae4qebjWFUUz+aB3utJNcP1hnyxPsubsjmlYWcCkhlE/EWSJU8JQhnCfsfc
         73Uw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792063358; x=1792668158; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+KhDh+DCKXNAlBFw3mfZ5XMbYKVN/XAmTIjiDnW60pk=;
        b=HdeCHXRjqDorAq0sL5z/vqOn/pcedJhaoVVlc2e3ZVDUe3D0hp4bhvIbmV+Ej6E3Be
         0xJiDkOCFQo3Z4DiffsBLXoZMVmPVHm1hVL2FRD2ia8w9UyCKjuw+L7uLHE9ILTAtGbq
         eO9jgmUCegbxWPlK2jdP1BQtVzSti16sWVO3/GuC8GsAzwUrjh5GkxZexGM2CmsvDjIl
         ya4TkEdPpw3pnDDNhisncekybNGtYivaXGJczkgULA+O/2af+S3I77npZOgsKPzmM3KK
         9Y8kKapwVW7zsmlxAFSjLpOQ1cBZuJKtMNPugjCMIWkBHiZVFUH/88n1Al6S2+rasyuW
         BjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792063358; x=1792668158;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+KhDh+DCKXNAlBFw3mfZ5XMbYKVN/XAmTIjiDnW60pk=;
        b=HUWo6JPJRQZ0UDZwT6T4qN2w3TmGpxdr4mwX9ycdrk2CLM014Z9/KZ2ZTD8KnycOqJ
         bnGs2AupGm4Yq2t0FOBnWQ5zqEfU75hIdIXJxqCqW5N/R4+3rsUlGt+YtJCQ8OOJAJTH
         Q63mrVKa6991B5jFY8jXFgF42CPzuM1ht09xODbdmZZdlzow4LZqptlyiAH8cc0QEQ/P
         dPXVPN+LsLYNb2T8irJ0FvbTT1rzSXrb8jQ1CJn2Q4xD8Pc92qd8gl7zj4BXI9a90DPE
         8pnkiXNN0jLzIxJczkKuIwa3Ezgpb0aOJbclkWY4lZyobvhbzUJY0BC7CQBOTdMIrqBI
         jpeQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWQEO2Dn2Qo+1PIN/ym5vJ9avhT/7PaCKXdy2YtFoP8GLUb2lZ0NPfG8xZQzw1eHE/gj3Dzg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLRMhLwUp4FEGx0csxiInKbS6in0kUF2taMESTXuX0P20tx2MbQ
	4sUrI3Rf/+xL2iA+v00zKCQirtnZDi7VgKu07X6Gx58/d7jp0C6mBsqkT9H8DPTsDAY0wWSk8iE
	Rad3ZMNQzXy7HiZJhjBKAxHGvxh6qmhvBffT2tqxrY15U
X-Gm-Gg: AYBFou2tEWuRrcl0vl7fU9QcVhjSLxK+DBNYhbeDrUEc5YmrqFGiVI3LujKI/psOPIw
	OJ9ZxQbBlGgqQyvmH5NCPq1svl9tXD6Lr14FyVQtSToLJ0uvbXOUoVwXVsN2Xw/k3HncH3OPz6G
	IiKrNQyAMkWfKmu/nKWAo2/G12LdmT2We2RATkhAxlkUEi3QkY41QilqLwRYAVZqzg35m0sKsFk
	1De5FdCRFhQwyAogpk4uM+7bW+W/pt2Q2UvJM9o4zDFA7EjqfLfuSdvJeGDQvcu42woRC0qN3B9
	hVkKueXGKf/gfD4NgQ6MdTrs0XoV6L4EkAiKe5EkjmVA/EG3vT+MXYC1oDE7rOKPNoAL+EeH5iV
	oeNhXDpjYqw==
X-Received: by 2002:a05:6808:5028:b0:4bd:c8be:1e00 with SMTP id
 5614622812f47-50c532f8a99mr18667751b6e.13.1792063358543; Thu, 15 Oct 2026
 04:22:38 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 07:22:38 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 06:06:11 -0500
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Aveline Noir <jm5905938@gmail.com>
Date: Thu, 15 Oct 2026 07:22:38 -0400
X-Gm-Features: AclHuK8pqRoiNT7w7U-dNf7fj0OwyC4V2V6EvhaoiQUtuVnZ8GqlxF2C2ivtqcY
Message-ID: <CANOyQmHo94dwHVMWeUfQsks0b30uZT0wuV8mDQ9MjB-HL0yVnA@mail.gmail.com>
Subject: [BUG] DAMON sysfs: failed update clears tried_regions snapshot
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On mm-new commit ad9f2d463666, requesting
update_schemes_tried_regions after stopping a kdamond returns
-ECANCELED and clears the previous tried_regions snapshot.  The final
result collected before "off" is then lost.

I reproduced this in an x86_64 QEMU guest running
7.3.0-rc5-1485016-gad9f2d463666.  It used one PADDR context over
[0x400000, 0x800000) and one default stat scheme.  The paths below are
relative to /sys/kernel/mm/damon/admin/kdamonds/0/:

  ../nr_kdamonds = 1
  contexts/nr_contexts = 1
  contexts/0/operations = paddr
  contexts/0/targets/nr_targets = 1
  contexts/0/targets/0/regions/nr_regions = 1
  contexts/0/targets/0/regions/0/start = 4194304
  contexts/0/targets/0/regions/0/end = 8388608
  contexts/0/schemes/nr_schemes = 1
  contexts/0/schemes/0/access_pattern/{sz,nr_accesses,age}/max =
      4294967295 for each file

The reproducer then:

  1. Wrote "on" and "update_schemes_tried_regions" to state.
  2. Read contexts/0/schemes/0/tried_regions/total_bytes and counted
     the region directories there.
  3. Wrote "off" to state, then requested
     "update_schemes_tried_regions" again and read the same results.

The guest output was:

  BEFORE_OFF bytes=4194304 dirs=10
  STATE_OFF bytes=4194304 dirs=10
  FAILED_UPDATE ret=-1 errno=125 bytes_after=0 dirs_after=0

errno 125 is ECANCELED.  The snapshot survives "off", but the failed
update removes all 10 directories and resets total_bytes.  There is a
separate clear_schemes_tried_regions command for clearing a snapshot;
a failed update should leave the last successful one available.

damon_sysfs_turn_damon_off() retains damon_ctx for final results.  But
damon_sysfs_update_schemes_tried_regions() calls
damon_sysfs_schemes_clear_regions() before damos_walk().  Once the
context is stopped, damos_walk() returns -ECANCELED because its walk
control is obsolete, leaving the sysfs results cleared.

The guest completed with RESULT exit=0.  Reproducer, kernel config,
serial log, and build/run steps:

  https://github.com/jm5905938/kernel-mail/tree/195d7017352a3d0f4a0475b98f3b03650f5c14ea/cases/2026/damon/2026-10-15-bug-reports/01-sysfs-tried-regions-snapshot

Thanks,
Aveline Noir
