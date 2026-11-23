Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455498;
	b=EwVg1IwlHRSnzcGrw2LSiqvq7HW2lo3qSIgCa2C7HCQuWYjSx8G6aryLOhY2/LX2Jeuq
	 FBVk0tz3owrV9l45EoGD84yP8H6B9IZn0Ty0K1M6LkwZctXUyrhxyMKWIW2bX1uy98khQ
	 AuvCLDhV9yh7CjpzAhebLbQFfTVL7IdDEZREYF8zPtdSfK9/QKZerPF46rbJCdMTM1WAr
	 dCSfQSozN+xTz/J4WnCf9531LIg6tDRDQ2XBvusWiR57Q2pI1+NsF5D66Gp83ttNbEDjw
	 UqcfIhVDxVoQ4Rr2sA4LGIY6UBntfQpaqUCh+keU/iEQt4MC0wfoU58S/gxVgfSo2oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=1M5yDkdzX/Rb4W+2dS9wDYqcjAMc8nYVaw63tkuJdGA=;
	b=hzY91bXFH2wHvroOJrQzRL3jniFzeB3ggQExzXS4y+OiP6oyzG9XvoET7bAdorSNTpUi
	 Mwhb2Tf81QqX1Vj7XipnD74vjuFm99atZ7H2exOXU83WQaDH5kWhDWdmqrb449B1XJRsl
	 0aaTGelGVbY/jrbt3s2Ba0qqYeQ7vB6KrB0nTOpjW5UtpuBCJppZkX/Ubgfc29h7GsZ11
	 VmqDWTAQuikQ2ZgPBF427Clif6UfeQNzzPiP1JqToL/CZtwzdc1cZym9FPpLR1ynw42qv
	 HqET21OrIqJZhPM0eoHZ/ijoMjhmlx6ETdrRw3Dtq92z4FYUa0mDS3Nn1zJOco7TFbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FWOrwErz;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7D8606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F7D8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FWOrwErz
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so4260638eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455497; x=1796060297; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1M5yDkdzX/Rb4W+2dS9wDYqcjAMc8nYVaw63tkuJdGA=;
        b=FWOrwErze2cvn6kIa1HOzG87oG7zNJMqnb9QYIKzldIB4GLihi/W9qHIw+MqRFGoFY
         /+JvveGyYSl8t7dzRROiLBSsWwVTTtvxOa0MN1dcr3ZQNZ8MRTPxAhQIUb/PK5lvG+zl
         aEFIW1+KBHOlnEJITjROzuNYnXkq/VNBHDSDVhPgTcGBlcLg0xApBhtOcDpmRFCJR+9k
         Imi+zx5iskElqbrAa4MH5wrkYUzfkKTqMnbNwL/L3xSnM5dmheAOESQ7JV6Jt5EdJGL/
         Fpfu5C7ErLXUL+roWEeoF6wCm1fyBqdvGRg9knad0hGr1cn4OR5CesJwwgCt1O6SIRHs
         efZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455497; x=1796060297;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1M5yDkdzX/Rb4W+2dS9wDYqcjAMc8nYVaw63tkuJdGA=;
        b=vBG9UxK8EB50l9qFA/yoUtjtRuymx+uF1/cVxUKNjsh0KK2y17kFWq4gSn9O6LYxuN
         kpusMaTqJjawfDA5PZev0Sr7MtcwZCjQmKkUN4BGKBsHZtNe/BheHqrVW+1JS/1OAlIw
         Ta0e/mdnLsZNKzoSy5ct+MbkoLTVqxgbIhcYt2SEVODTjz99ZlvAg+3NdRF8buLu3qnK
         QmSUfuYi9Xy+SgCoS+QxTMordzkBdByXA2QAqtU+1ZsmH3Odg1f7lB1jffNvMRJzcxSc
         v7Z3O0ZJXJtWFzl2jeSvtKGrNjfgk4oXTGbhWhkQWaVW677zuCI0KpDcer2BOl3xgsun
         H6jg==
X-Forwarded-Encrypted: i=1; AL+hErHpCKemNQNFMj+RkN33RZfCOMooZpZD1imYXoaX3WBSnWHdnyZcKPOH7OCw7j97fA2g9/DBzQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z++lho22819qgkZyhil9lcMi57MaylIJnbPRzITBAlU4Q5NH7K5
	a33U2hsOpjsvrzH/VHKIk7R1kdVsQEFb4Ziz1tESdSwLUsnEA3FRfpCm5w7JJu2MSp2/5A==
X-Gm-Gg: AZFdTZdo2yfDXzWcQAR+TdMxFbxCmfuPtYZ6BXAx3JoQNlbDOOCmyv9Ws5YW6GgvD3d
	3ZMzDcJrxVDco6XVT3DJmzMYuvkwiOQrl2B32T+d+THYecUGqJIjLnqz/a61HR1gDrCzzm9FfIL
	Qfz8YHknbXzR9DlnXbpnZZLEBXW0l4EKw2ucxbyiGKyf06CYX2yxYrLBygvaemuCkbThBLMin0q
	+Ec85IJQKLFqjuag1UPkrXpfsnzr3s2evJ111ikwbsVxG3FoO2OBznSVHi0PAHyPx86IvLB+JQ8
	tKKMj/9WuxCDnjtApcxkM9r1vDKliZpK+25HA1l+TRd4Dz+PHuBlb+OfMjrGr7rlJkCIDcTqH+0
	Slj0ydn91cXzZVtarD+NSBrFpGJa3SsePQKzTyS34WP7BGIoC4gLgljLRzbXnZ0jJZ9aeQnFpjB
	ndHdMplB6q5j2Rm+SMW3VJh3COygfK/J8Rs9U8a99IcCguBWQxiAqPckjMzjdl7KilKuVW8VZDA
	t9GsZEciN9qMatxmuj5d4pDOckY6ChpqfFW/0iXglZf/CTbFjmXrJwVj52JVd7yjiwkl85Xrnja
	1G6atm8bEE76bR/SiKgT2UPkJmMia6imcyPi/9HluaqH6/qaI/W1jcRKhyWtMbX9DQZetVLyNkn
	jOGU2WqB2lmZtRy4WSwpD/eMUp9+Wmp1bUHqo3bL2W/3vAE/BWd2JOiv8XB4UyA==
X-Received: by 2002:a05:7300:f483:b0:384:e31e:3c58 with SMTP id 5a478bee46e88-385714160f6mr12146290eec.33.1795455496670;
        Mon, 23 Nov 2026 09:38:16 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:38:16 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 21/27] mm/damon/sysfs: add user_report support for
 report type input
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:24 +1100
Message-Id: <179545256489.4.16849196400062499517.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-22-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-22-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 13:00:05 -0800 SJ Park wrote:

> Extend the mapping list for data attribute report types and user
> keywords, for the USER_REPORT report type.  Use "user_report" as the
> matching user keyword.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
