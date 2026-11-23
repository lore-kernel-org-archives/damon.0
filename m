Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455452;
	b=WeLkPnxSCXYFgNH7E4lPx4mmKygmjvHvRHbBt0KAeAFp/JsTbcvayc6kxyqyJLGcAzlY
	 zzEyu3ipD5RbAPzh3ZxiTd+Ai737XdTzQzOf+MRO0F7Xy3TwOieuZ8GHUspAp9QwVct/O
	 TZsmbz3k7iklfpkqoG28opHRIxNKIYRXDOzdQgVtkin5aiHLmgAj86ls1qwHMkof/VU/K
	 REQ+oyS/NT17aseF2OAft6RzsYVeut7tElQ8FR1PxHGLEWccVfbYIywiOGNC2gXoV6ymr
	 joeDb/RPio+3LWk65VQdnIBd7XDW0fmxUQNG+UpuEoWfMCGBUtsXaIu0Qw3TPIRT/og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455452;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=ltZNAhIvh92aCC2n2MQF/osOH2UAWT9vx20uHoniKkw=;
	b=BlUSyPnVZ+0PpaZ4LMiQ9TSlXh1WlK85mZb+Wa5QGUQQGgcX6hImcLk5P0IUiSTcu+Uo
	 twhS1mQLlBqncEQo7hh+8lv7G1iYBktIx861s4lWxmh4NkprUj2ECai3KJaWJ2pjDRgmj
	 1Hj0ft+uVhzAkI2sQKkLO+9bBq4MeNpov6NBYacfH6fPt1y0RJ/ClL0VvHuCOVWIV8DGg
	 uvKyhdHxlpnXMMHylfU5+Vymhid0lJ0k6/8UB3skxdY8VMHyuqDWOyQyKZFEi8U+THm1y
	 Sl+Em24xBIS2vwpyqN5TrsxkGKYCvqNRqvUj5dQmYmYw9m8Oe8LJwvJuaECgv0whAng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tyVYeRZP;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82EB606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E82EB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tyVYeRZP
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so4259894eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455451; x=1796060251; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ltZNAhIvh92aCC2n2MQF/osOH2UAWT9vx20uHoniKkw=;
        b=tyVYeRZPYADRUsemwebnk41wHBq0tRoJ4CzLknaSvl2P71I4V+lKRfH9eZIDwmK/hb
         h7Og3DacAahTE1pKYG655zBzUZ48yi9FweaLsih8l0pWeSI97TS42P8MXXo6T086+b0t
         301+/7RgcjhgJufAi+eLf63sstlFILlKVdVawXfHEa0jcG793gs36u8qXXQimfnot24Y
         zll00qjpRgfuJ/oykaW9yCOE8fDpNFvTh+o0S4lUQzNb9fWN54OeM2+uWnBB5PPHfVy1
         x23qUA7O2q4iMlfjUsp1HshbpVZXgGsjn5OMXombNwhjngGrN31k77uXE40dtNhtqxy/
         GwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455451; x=1796060251;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ltZNAhIvh92aCC2n2MQF/osOH2UAWT9vx20uHoniKkw=;
        b=eXTiII+UEBPLXyugKe6swvN4rGJVHvvPoxrGIWzAa4OdMuBFnnhQg/zFksiUdf2h71
         TvGbQ5cUvd+C1q1y5LjIHjoIzjUQET8VW0othQbFrgSHuaVUxoyHyb/pBzHRb8T++T8v
         r+NqO+vQGfgplm3LJLBjIQ4//fvRoFqISHZOvKNGlMlYUzap3A4+PkCHa5A2WuHnaoP2
         ITRT0+LuN+wLgH73+uWw8t5mtlkBqE1JKbyACJjm9hvwxSPY2cUwohpqmAAjuhR4SMpY
         H/QdCBSRkuIYm5I1BQJ0q5pPG3ARF8Kgr8pDYAx3ypyJEWWNmxcISMMv/bWeHbqKLl0U
         UkWQ==
X-Forwarded-Encrypted: i=1; AL+hErF2ZIEEH8og4yQ62zcxBOiERWZ9LBSJoMxOGMEhhdcs7nfyc9f5lpWYvFkhvnOlFTat/KMmKg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Lv9tIahkXEHI4hsn/eXFB6Deyc0qpTvUZ+yUoeHDNXyLw/qsc
	n8U0yDac++cKo72OyQrEG0CUn+tlSvHljzv6is6grdomB2CJ+mSTb4H1
X-Gm-Gg: AZFdTZcyuAUA++qrdM4pyBDlcE2WErBzfOzS/808PQnxLVCG7/hpq+MAsG4hIVQyrhR
	U68MZzd+MDxT+Ieele2lh3WxIojnLPOdb8ipM9TmdNh0fzpvrvurLNp+wYADw9LtrEjo0Gf6IsD
	TRmSdZdrvOWdcPPGNJuT63XuliV/4vlHXdW+hTlhy2yaufMrWEZ7BS5Dmhr5dnGCoX2hbO7nevU
	yRfGP/a7XwlDs6gD8eNjn5XCA49YsHHQUwAEc4tENTP+sMN3B/igDJpvAvPRNI4x/EoWH51e/pY
	hwAJEe4yHTyNsOWFxC4M7fnF1gnvaU23KnwSOlyrFm5m7FIhhbRvWBMaaUS11wYsy4ALCn8VXeg
	auGw/pFX4qaToUUfvKnVVA5knGJtdaU6mY0YA7JLzVv9tjbDv4pe0AlZ9KgAozZxOiSyob0rDwb
	6OdDIoYIsXUr94z1UFihvHpQNGhBxIMi0cZHo/0AbDu2cbKVGo/pza87LOYnxLF8EFBV0KBhKXi
	KygPSMmszOXuHP3EukB51FraeyVw+9t/hxXzKYkMpNxr8xKqnpSEweBqjlSjx7mBri0iELOSMv/
	2VsaTkdXVXuUrKxFiPD2aNDh2MgjRS9D5RyI35w2p7IvcCWAhPqwNomwJ6zX85Ag5s3SdmL26t9
	RLhIyQzE47/Bdlbr2BYC7GWIqruCDGhZbU2Unx25nZ0RTciP0QC9EnoYSC+qajLo=
X-Received: by 2002:a05:7301:4710:b0:378:314:4042 with SMTP id 5a478bee46e88-385702587c5mr11930215eec.14.1795455450833;
        Mon, 23 Nov 2026 09:37:30 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:37:30 -0800 (PST)
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
Subject: Re: [PATCH 16/27] mm/damon/sysfs: support REPORT_MADE type probe
 filter setup
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 04:16:19 +1100
Message-Id: <179545417951.5.1330697247346580936.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-17-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-17-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 13:00:00 -0800 SJ Park wrote:

> Accept user keyword "report_made" to probe filter type file.  Set the
> damon_filter->type as REPORT_MADE for the input.  Setup
> damon_filter->report_type with the filter_report_type user input.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
