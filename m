Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4421CDFD5
	for <damon@lists.linux.dev>; Sat, 14 Mar 2026 02:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773455768; cv=pass; b=qpib48qBnnxndy1Dlle3aInunUktibxYk5XkkppLECcXnalNldr6S9BrXpYvdrVCz6dpErYtl8Fo2c6xDCCoYVpTMWtQf2k2AVDlH0pKrQvcX32wUFd98AWh12Cl29QD7fhOZVqNEWisxAubR0uhzdLoUDRJ8qbeAfZad7IMOFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773455768; c=relaxed/simple;
	bh=OL+TN8sx56UvS//efnLpyc78WNqM58VR7Q01VEqB9lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svmBx6MjK6ka/R/qTGUKoZ8tbhpPhMQkOerHSAuCr2boUj4JVykib0QfWD1CKlrbzx+/MiT1a93SBEVkcfuyhxedcgHyD5ryt0WzLuMiSKkpvFYuLXLoLjXqzHWJ+Bi0YIEu+cx4ZFiXPXtgqfXUlkcRdSzRXbRWabVhg2aXoKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiAcLoZ7; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiAcLoZ7"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64c31ca77b4so3022844d50.2
        for <damon@lists.linux.dev>; Fri, 13 Mar 2026 19:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773455766; cv=none;
        d=google.com; s=arc-20240605;
        b=cAAb13pRyRIwJV+PgH4bTnr/MxcNmKfF3jmeib0qzEiwhaciy8UKxD1uayzEpGPKCu
         0MgLSXPEis6ewSF0HQp1GFIvF49NI2FpJqDO2WQR/PrPNjUxodCS9KZ4zW+z73VCnjO4
         MWOU0cgRek8a8QMRlXvJzX4NXZDC3mzX+PygplPtne/yHp9qqrmnXb52Udd5sAPiCf+P
         ANmXg5JMlynfsHtRPzSA1X/I0kPsvRgxPQZ05dC5poe94kfRDyULQugN5QYFk038AYYL
         4wbuHzlcs5Pd4U9SpxxehqTl+uguk9Uol1h/l4lY1/RFGKyMlaJGCW/N64vv4hWQ31Yo
         IUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cO20WwNIzRxyw30z6OHFbWFRxuc4T5ngZ3OGaMZkebE=;
        fh=vziSB+WFnBJEbC6uotzntTmEbm9N2V7SxyGgG0BHRZ8=;
        b=aBX/Xsw0c7IrR5y+vfmQgNzoEYt/iJ6k40M4RLWQfJZFmRInJ1CW9aKQORuSY+dRyS
         KzL6gHuV9zobFSIPIOQ4eO8SqA1B98yHubICIeKGqYOuZav8yDUTrpth2/xnHbHQKki8
         qgUtEErDPEXALnca9SYxMQjaos7WqcZ6HsOewwQRRx/rilwZ30H9E7VbGVU+MTGG1Eh9
         xTD7juadfFtbE3KDBDKkbXG6bZU6oVP/hbVE8ByUbfDuJnFCZMPwWFmrEYyc48xDokwC
         WFv8C2EUlXWR/WDeVZIsHPwDWrbWYEi3oNRB4VB0g+D1mJML7IpF8pEoZj47h3e5VFex
         wKlg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773455766; x=1774060566; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cO20WwNIzRxyw30z6OHFbWFRxuc4T5ngZ3OGaMZkebE=;
        b=UiAcLoZ7h3k9SO+1etW7gaqiDlXDxaaiEQ9VkX+oGlEsEY++0hE7LQ9HikuGT8I9nA
         WU8dxFLj0njkLnLt/E+3vs46V+s92f4z4UlZ4l6LC6OQkAFTxmm4quh2yFKdLKSZjZIE
         8PTOr/IV6v3MgYH5ywcLLWjg0KNbGmZP+PNPLu05iEfj3rV5DhZ6MrS/rm/iz5kcZ0zV
         CQpaun2YUDlkWkhDXLvzoRIpPLdWpljstvAWTjPlKHa5KIvGdkro2uOKUtzWwfSsHKq+
         KTzMmWAHAdIjj1jeHI12qlifwbvKUkRjdK9giYvOcY3oWNg6BcAqRt1vv7Eg6ucM8wS5
         gmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773455766; x=1774060566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cO20WwNIzRxyw30z6OHFbWFRxuc4T5ngZ3OGaMZkebE=;
        b=mEI97y5uMeAjdjqcjgP9YmlT4VwmpzM8HuD9iPBrjq5DMo641XLPgny/pPufJ/7yEC
         X1H79qrhWuUtTitOl2bTpBxSDOIMrkHwfA8YUimYOJaoA4Bi8TiobR8l57xQm1p+G0E2
         2Z7bcJGZogN342bCudCgE3XBzDZoBpdGNVubAjFP8RZiymEExijKrB5YGSIBVqGnn2Fy
         N0H5ry598Fi80T1W3pBvb8K2oiGro5PMzPCEtTx9hBSb1pZ3nI4QOsb6WjTsw3h+oNud
         UAubIvAWuouHYB0QhBWqwyr1LOu+c1woXIfDWsUlu6ZzpVK22UArb4iEM8bCL0+g8gJh
         C73w==
X-Forwarded-Encrypted: i=1; AJvYcCXf1mqt5+7SkwxXVoBckdyY78GKTs2bl07vv/6cHPMp3m1t9dOLVIQw8bpPtrhQYaD3x91onw==@lists.linux.dev
X-Gm-Message-State: AOJu0YydhXha9T1xjFyRhnfkbKTVU5P2Ee8FNW3vNs/+L6sMwrQh2wrz
	cIHw3z+6p125zWseR/hOIeoSohG18l7tQLVivyLhvoGZq793yG0I58z518+DqpMoH4ha0zABp+o
	JYwSoyV4EaGs2z37n5zVaa+HgrKvuL5hQfKl6Vmo=
X-Gm-Gg: ATEYQzxvCiRKlyzHw18REVO5U9+lDNGnTYT7J5Gk+UNKUchM7Z78HzqEGMUWOv5cSEc
	g34UU02Bz0Ij7bWHY2umuwW3PSwelzzd8OMyn1JRY9mQo6kh3ws7GjslN9/m90u7/SFetY2dclZ
	05uEG45Fj/y49q+QRUP16tLiRsl9ixw/2d1PJibZgt7t0nBYsRulkvGEi5Fbyv1uyYNIx04lugW
	KOv2SPgQfyFo9dPvVyrBlo5j4mJaM64wDgajKeG2KOnuvhlQgZobO1jCWCrNAj4B6bW5vGJDjJs
	JF6Yl8EplP6XVjWvaz/QGIbXpbifmXKgnnVrj5OW
X-Received: by 2002:a53:eccf:0:b0:64a:d2bb:9072 with SMTP id
 956f58d0204a3-64e63073fe2mr4556761d50.53.1773455766429; Fri, 13 Mar 2026
 19:36:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260313110953.37465-1-aethernet65535@gmail.com> <20260314005131.80825-1-sj@kernel.org>
In-Reply-To: <20260314005131.80825-1-sj@kernel.org>
From: Liew Rui Yan <aethernet65535@gmail.com>
Date: Sat, 14 Mar 2026 10:35:55 +0800
X-Gm-Features: AaiRm50L5vc_CKwcot5sByL67vJTvKzPCCNWbVkzvFACfjuR90YpGehqhao9hbo
Message-ID: <CAPLv50pktuzn7s9zW8E+36Oinjj7HfGhD5YdOaC6hNE2+OBL=g@mail.gmail.com>
Subject: Re: [DAMON][Question] DAMON_STAT and DAMON_LRU_SORT module parameter conflict?
To: SeongJae Park <sj@kernel.org>
Cc: linux-mm@kvack.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 8:51=E2=80=AFAM SeongJae Park <sj@kernel.org> wrote=
:
>
> Seems this is a duplicate of another similar question [1].  I believe our
> discussion on the thread answers this.
>

Hi SeongJae,

Thanks for pointing it out. You're right, this is a duplicate.

This was my first version, but I resent it because I realized I had the
wrong CC list (I typed damon@list.linux.dev, missing a 's') and it
didn't show up on lore.kernel.org immediately, which led me to believe
the first attempt had failed.

Sorry for the noise.

Best regards,
Liew Rui Yan
