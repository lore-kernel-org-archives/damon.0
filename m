Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEE1385515
	for <damon@lists.linux.dev>; Tue,  8 Sep 2026 06:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850143; cv=none; b=rvCuDMipVA3G1DTxUZB2OIYKch5f5rHqU6CE33TXHCqKBSFU0Pl/1DTqU/vHXs5exi/R1AmlVozKlAgW8eha5I2vp/g4ea5I31+OeIl7ah+dfeuGsSXL1T0nbeWlDrCvabec02BO9K3zze18CtZtClBHnz4cpw7Zh2dlW0DVqRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850143; c=relaxed/simple;
	bh=xUUF7UD2xCl06/7p4fCfClLtYgEYmyE9IABYO7UCbek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JD2abLqBwOANsfI/v/TOuKMLYZ8iHcWuT8/1wqBFNJ+E+hcUgOXvIfsfZGHHVwOX0xN5n04eR73G2uN8bOAcFbo2rZEGtKQjC/azu+kddar29wAgkMyLku6fAlI6Y1wBIvsAkFTQzb3MACMqt7dtZpUN7s86NHuL61dUpQwpu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ol8AmTKm; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ol8AmTKm"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so4610476a12.3
        for <damon@lists.linux.dev>; Mon, 07 Sep 2026 23:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788850142; x=1789454942; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ieHVtiuPPdzHJk3HRFuoVkUtejOuBjTV0evlYx/E0iY=;
        b=ol8AmTKmG1qRX091MY1u8EUO06AV7vQtbkFNHndAKJxxLpLJvZ2l4jyD5m3FR5S4uf
         55yeF3TCkzSV/A7yusBDG5zhnNhNLDBXntGzvuGYDfJs8T3Etjt4PcrhiDRbbhteesU5
         KwQYpfJUb5SWIHW3hNiudv3gmXQwTuzuZaYbIn0hxtzNCY37FOysGYD0ATczjvsaoLSR
         HfR1geZV/4WlySsd/Qih1RZS9xG578HvzU1PD4gJrypHP3U2NXpOVZlHKTxNvwE09i6b
         YavM2CM0wqqCb8tU5/esKhJtRUHuUl3Lba/2CQJe4jTy7x3F2smnUR3OWypzbpQHXgop
         EtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788850142; x=1789454942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ieHVtiuPPdzHJk3HRFuoVkUtejOuBjTV0evlYx/E0iY=;
        b=S4s4xr4/byYiMtzgEAmVQEWQXpxy2hCeM3hdqDaQ3Ni/E0S4tJNUf/UCfM0CtNTJei
         xBOa+FLzeMiYO0no2maB4eyHdeGLtunkDPRAL8RbzsTTcXCCFvNrV9YbQOYsnqD8Dqbr
         iqUNh+Vv14M94ljRa2Y36G8LfO4z2XXbs29FMEE4llHvVNaTUygkmicPpOr2JdAJi3rq
         iqwM0KbooQrPCzz0nWqtf0AhR55bHkPi0rlRuOYqVgfxPwwbx8bvHEBORcxhNz34YCJT
         eCuH1+BtJtPeqfvz95s+UWpgnPee46vXOGlqdeUnkLepCntvb7SADwQWZ85ry0x2Il4Z
         /gwg==
X-Forwarded-Encrypted: i=1; AKwUvBzccNqOakx/S83vTFu8bJ5uwVG04t6W3O/NcUWKBzYmw7R7t1YxLkZ4evoNeNgOsWlEiqNQvw==@lists.linux.dev
X-Gm-Message-State: AFuF++nM1idwvQ6WnUkvs2t+egAN3sNyB8b+J+h2fcgl0qsUFArPNpsk
	Gr08lWBBJURygrhs3kJQM3kOSM/ijOb/97CxGDACV42TKL4vjPDJsYo4aUOHfrXoSjU=
X-Gm-Gg: AYBFou1r6NRCAjqUz5vgaXGJRa+byPKWPV5g9vIptdHzl0PPND+1P99e8a2P5DonyNH
	p1d66LHqRQpCLOnq0D1Htf7/7QGDxjeNVIG3zl6gLZNzVa4Xdy8++XXquA7Q76xqxTERdG4vblc
	xiu57UAI9k4CDN538iIPGN7zaHfSuoeFPUqdBHzcAODKYWvHo56sL65xGOQaHCwJlfemTGMXnbJ
	IYAkQrYIF2AAtbQcnET2dDWvGdl3SQP4NTgEZi7RbCFcod0oqG5wLEAVuk+ksJ0XAYorTtvKrlA
	JFZFDqQeQy5eEogWrniFokT0yLD3UU0n9n53zfAZ2AOwxT6FlG5JQ5NrISwYGcYIVpIdum9sVNV
	rKSQ4nFnuOR89M0+XpH7tA6LuvFj7fyx+1wNs63iezuYHCSjwAcmP+AG3lqqPVeLnKPtOMcWyWY
	arskoCoyYpkx4hOdRxu18ovFEva9kNdpuFM4AUjaR1W6OSMWxD3OMwp+oh58QQlHWL+M606+0=
X-Received: by 2002:a05:6a21:8887:b0:3da:9f19:bf2 with SMTP id adf61e73a8af0-3da9f1918a1mr7504014637.18.1788850141767;
        Mon, 07 Sep 2026 23:49:01 -0700 (PDT)
Received: from localhost.localdomain ([104.28.254.47])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243bfbe3sm31139468c88.11.2026.09.07.23.48.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 07 Sep 2026 23:49:01 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	lianux.mm@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/tests/core-kunit: improve nr_samples_per_aggr test isolation
Date: Tue,  8 Sep 2026 14:48:23 +0800
Message-ID: <20260908064843.32067-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908063635.2208922-1-kunwu.chan@gmail.com>
References: <20260908063635.2208922-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue,  8 Sep 2026 14:36:35 +0800 Kunwu Chan <kunwu.chan@gmail.com> wrote:

> The damon_nr_samples_per_aggr() test sets both intervals to zero,
> which exercises two different fallback paths at once.
>
> Use separate compound initializers for each case so that each case
> tests one fallback path independently. Also make the overflow case
> use an explicit non-zero sample interval so that it does not depend
> on the zero sample interval fallback.

Hi Kunwu,

The separate initializers now exercise the zero sample-interval fallback,
the zero samples-per-aggregation fallback, and the 64-bit UINT_MAX saturation
path independently.  Using a sample interval of one for the last case also
keeps it independent from the zero sample-interval fallback.

Looks good to me.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>

Thanks,
Lian

