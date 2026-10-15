Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B264D2EC9
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792063456; cv=pass; b=Xic7r9hHLudN+UgR8jlLIhSbYkMOQ0ir1wWo9Y3kwe3ubDoumBHKJViGprfFczSyis0WibiImFKP7yvlqORm04yMMEnaGTsZznPUJxxKc8AkdmmkqJrKk/JINdSsSvqd9RKw8GIFEoFOHpfekc1csFJZjDUubONnUgUMt/Meb8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792063456; c=relaxed/simple;
	bh=4Mrb+8X/5Y2CNFjpWJLndPDMubOpHWH5ki5nFMCA904=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=liyYHWaOLPk6O385h0As5HHp4EcEL+D3BFNwgQ6x301VsibO+eMZs/RFaHIe/O6D/4iKOD6r2uvPZ/c7eQkSfQYjbq1BrNr+GOgX1lcP7SFQ6JiSnyytpusLVVaCVue35HVfL8Ru6kwwwtwwl1VH6jS6FUcnbgVBLPBmN+2pfEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIGu5V1f; arc=pass smtp.client-ip=74.125.231.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIGu5V1f"
Received: by mail-oo2-f0.google.com with SMTP id 46e09a7af769-82389e65a09so988092a34.1
        for <damon@lists.linux.dev>; Thu, 15 Oct 2026 04:24:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792063453; cv=none;
        d=google.com; s=arc-20260327;
        b=GTM+wIpMpSYjd33i2M0vTgL2GfL9LuEvy92EigLSvLt/4mGWd/OHnP0KwOQLKCoZYo
         2cg4h/86sRpjLy/FNj83WXMvBKwuSOLoI3de/nzy5tIZpnrwX2AZh+O1xWseHKYdD3+b
         /4G1lzBMihX4P0wG27VanXpW/Q7vOY3ch0bXfeUKeBYc7UlJ3pmb/XOeBBmkuhzMb1hG
         7P3NmgF8elHUStDf5s/8MXk7R4VUSWaeDKH1YEf/HIspGv71HrFvrhjjH5lZ9P0OWt9M
         n6B2x/Eghb2XKsPzrTvURdWYB36/nsBVJphdPBz7wl+2PlCwhyKekmiEdQklJxXxguQV
         yrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Y0ZwfiBQ3RpBcxHsrin1gDEfz7uV6dXypoeGwMb2TIw=;
        fh=JaGC94PYWNQq2+St+wiQnrQBAidiey5MWq++Vj7raKc=;
        b=CgLhEHR+arjuG5easBbNBOLdBpTmVSXvV8as3UtPyl8S/oGMYDieHDz+G+35rHLuCw
         BOHHeFRZlPLbN6vWVSjhTjnMBKqm/M3t+VQglMpfgU4DWEFsD3AEOaTNeeokJ1LC5hG2
         typfs+2D/yhRbOVXhkLLNAbCMySHU3GTLtdTXe4Ti4vAtpy55KOOtKS3TRxLVTjWDUMe
         Dl/q95ClwM9D/KjNGA85Zc0AcfAUjHAUXHycxifir56zHovGFteN4uqgU++cbIHPBqYz
         NslZtvoPkMOAch7bbneCcP4Dt0CWTTCHVgR0ADibJIWBAdOYR662bPcEw0f/JP/jhBWb
         ii8Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792063453; x=1792668253; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y0ZwfiBQ3RpBcxHsrin1gDEfz7uV6dXypoeGwMb2TIw=;
        b=TIGu5V1fYq/NOACUySbkorQnl9baiy7U5uE+0fW3HFwO9y40v2eAIAyK8VGhhTOUxq
         CjANNuwuIDoyEz2n7Qf5CY0bjK0+/LOZNCwYOPGpYH2DFyo5XrYbmHJs8X0skvNdIBJV
         vpwZV3vNyXIqQ8TBz3D2KomSUYBRM4s4ClnzfX2GpHo32ZnpImO7k/mBUny1OOJuY7cH
         8YSVemvS6D3A3RBoaNyMqzgkufKdokeiJ4TY4vhpjGmfcpoGFySO3CnlsfVDWtu2h6fl
         bRIqOfKE3al0499io7hxHFKiGHgXEEWUnH0/u/gJW6dYQBvRVqpx17sge97SVDI/keL6
         olyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792063453; x=1792668253;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Y0ZwfiBQ3RpBcxHsrin1gDEfz7uV6dXypoeGwMb2TIw=;
        b=I2Iw72zpw1UBTD6l5QX91LRjU9y5M8huLIA9tXfIxNQ0FbuOGImf74IEBHB+dl3SRB
         YRjh74IKguE2kwYNzerydBUZSWIyi0ipUzzLcm416kXzjf3POgPNN7+j0bzIL8wCdzJy
         KU9SHs8GDd3aptVhvGuMLHpKwb/E5Ym4gdxg9MyLL4BN4y4Ov9Zi0g7SWLc1S9LmTgKm
         le0K0OxJ+9po2F9Oi1Xn36PrrnTW54C1w7p0PyO/c+2GaXclSAOZo7b8G1U4CjZYOtGQ
         T+RwZEU8dHiUtdkJrN6Fk7xKYvllV5ZPTrthd/kUsLp/9KE+XMMxTK0g9t7NlpXaxCnJ
         bRBw==
X-Forwarded-Encrypted: i=1; AKwUvBw6rWcEA9lv3WlDIMaSl6aVbMT5i86jPmrroOv8CZKDDFoRKdLFIUjr8x29hynOc+j+92lK9w==@lists.linux.dev
X-Gm-Message-State: AFq9FYIU0LwgMo/eRPke38iXDaORhoW8LMBaWdVfQUEMkZVKrrM1lrUh
	ut2QfRdlOxIJ/F+HakouWeLhzSWCbhlDtLcB9uUSIvsMUyOhn0xh6iGam2DxheKEa0i76jPAVgD
	dWq052P5DdzTAyiYzU7FNaDZbybUuI58=
X-Gm-Gg: AYBFou2UyuPKpKPMTgcM3yokKJfGSrXuxCHon4fKNKNxT7Nh3ml6mG5Lp6fTmIiMP5e
	uM4nne/OrhPU/Kg6io+l1FeFT1nyjLHGetlErs2PWC7afUuXiyLS46DXQhpKhrzc7QW9pWJZ42t
	9p1TeFF+CDPXnXbmfuoHsJlZGGnaqoCa3fJP2hDfEowrIVg3Ssd4qcLuJBpp5sCn3S1WmuGFRb+
	3v1l5Ye1lOVseHLcnH+uuUc/3BXmIzjIYlcOlKvE43FDMHyaTnqKWvsz863cB7EOi3MQoBdMkWj
	w1+8M7mvfOvZMMnzZgukZfSymtezKpNkGDvNpMVmc1ZJ8Qaxkp7oYayMAdzTVbEsFfd6JPZXrm9
	AtDbwEZD8bLXHEsaHFvRf
X-Received: by 2002:a05:6808:138e:b0:4e8:bce4:993d with SMTP id
 5614622812f47-50c4e683baemr14333600b6e.11.1792063453079; Thu, 15 Oct 2026
 04:24:13 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 04:24:12 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 15 Oct 2026 04:06:49 -0700
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Aveline Noir <jm5905938@gmail.com>
Date: Thu, 15 Oct 2026 04:24:12 -0700
X-Gm-Features: AclHuK-Z1dKLpbNU8M1HVDhdDlGkqdOlUqMA7Se8cYihkhi6OUAS2FWVbX7zVVg
Message-ID: <CANOyQmHad1vamnZT12M5yPrJ69==Pt1U0+MGw6u0MuNtr-DRCw@mail.gmail.com>
Subject: [BUG] DAMON_STAT: idle percentiles out of order on 32-bit
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

In an i386 QEMU guest built from mm-new commit ad9f2d463666,
DAMON_STAT reported these memory_idle_ms_percentiles values after a
statistics update:

  guest uptime:       22.51 s
  aggr_interval_us:   3200000
  percentile 0:      19200 ms
  percentile 50:         0 ms
  percentile 100:        0 ms

The 0th percentile is greater than the 50th and 100th.  The guest had
256 MiB of RAM (MemTotal: 254216 kB), a running kdamond,
CONFIG_X86_32=y, CONFIG_DAMON_STAT=y,
CONFIG_DAMON_STAT_ENABLED_DEFAULT=y, and CONFIG_COMPAT_32BIT_TIME=y.
aggr_interval_us changed from 0 to 1600000 and then 3200000, showing
that statistics updates ran before the final read.

In damon_stat_set_idletime_percentiles(), the loop compares

  next_percentile <= accounted_bytes * 100 / total_sz

where accounted_bytes and total_sz are unsigned long.  On 32-bit, when
total_sz exceeds 42,949,672 bytes, the wrapped product cannot yield
100%, even after all bytes are accounted for.  Upper entries in
memory_idle_ms_percentiles then retain an earlier value or remain zero
on first use.  DAMON_STAT monitors the system RAM address range, which
exceeds that threshold in this guest.  I did not capture a per-region
trace in this run.

The guest init read the module parameters after 22 seconds of uptime;
it did not write to them.  The i386 config, guest init, serial log, and
build/run steps:

  https://github.com/jm5905938/kernel-mail/tree/195d7017352a3d0f4a0475b98f3b03650f5c14ea/cases/2026/damon/2026-10-15-bug-reports/03-stat-percentiles-32bit-overflow

Thanks,
Aveline Noir
