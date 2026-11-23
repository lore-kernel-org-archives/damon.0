Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435371;
	b=nEdwDvbOoxaIsCoZ28Btq0ukdr9NmL8AKVxvd8Fq1upELt+SZZsmYwdRjWWak8dWH4nH
	 5NBa2EOB5jpMesGBKnVApIEucfe8HgQ7kFs++8KiGNthILxME5r56iQhItUZ59qQZp1F0
	 bubs5kik+jOpHdUYCBo11mJN8e02/2iAuOwRB94FUWOXBatpvmgpIS2uqBVJO6xDi/eYH
	 rdvV5kPyX8J2XXKk7E2KMlY7O8WYWM2Qeg08PLJH/sOaiM0+rVqenEJHR4jIAW3si/7o3
	 h1BHFLWcG866v2BBx7oSK3M12e24rILuXSb7Y8G2wHGqmooNVnAi+KSZ459PnlRVTqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aEYCsDgrLbetznMLuynoSw9eu0G6R9GrkBLNrIpjTxs=;
	b=KAOg/kJwh0hbGL4loUh+ZatZxJpWaoKwGGopCBGnOgHMckXd8T2P6NRNEm2EHCq1UzOw
	 T/mFV6M4PCHe0SXkSrRjtt4ybee2jyV0DX6FtgRA3HmzUiPs5erl56n4jMmTXvXm6uoc3
	 h4/11XITxQ1AwSrsDzYBdPHkD+7qYzsDu79+ReEM5QAd5RR8IvV/OyUhs6wj7B2u+CnQM
	 /rYt4hfh/32l8Xr7OIV3Whn4N9QoPzOfRXGUCfx4LXN/VP+TcwqVYg2WUbVIZFdIdfIO1
	 hPVkJ+Q8MT3HEJdJqvL+32mIlw2M2+jAyHUFZ6j0D0VZYvOsHU+SkbIBpyDgL940J/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="hrU/ca7u";
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEBF606A32D
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 12:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEEBF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hrU/ca7u
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-15dd124bbe7so1796291c88.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 04:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435370; x=1796040170; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aEYCsDgrLbetznMLuynoSw9eu0G6R9GrkBLNrIpjTxs=;
        b=hrU/ca7uE4MMI/TKN2o2KlnQ3yc8d8SNUcU3EcpWWsQCXJ8rzjhNWFLM1TGnkAEWWs
         fdnb4Vex+CAdkfC/oOkL3bfQUfN0jK9qid+b2Svkm54nmHyN7JqYU8jplo/gFSNirAx9
         fxam6M5SZhbUZszKFJ8yF/4rWtYjfx2Xu96XwGGT/PhO2vRY7IVF6Kh8dsNKpTbMnW4v
         bGef+Face4kEBBDaU3yLuYARBHWLx55JfgxvO84W8q+73D9EaF8FckDyUheeLs0s11QR
         GodswEDyqZEKERmBgNZB8ORkXVldTufS8SeCdbyKASqAUWrrzcGF98WfmIAckHtjqJy2
         p1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435370; x=1796040170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aEYCsDgrLbetznMLuynoSw9eu0G6R9GrkBLNrIpjTxs=;
        b=mV4kcO2AH7Euoytw9o32Mqn3fWajZdBMBC/cBQGY83vxPVKrvfuWkixkObGsSLSmiW
         3V2vv/fhI0Zx+PV4wzwo2ZdbOsNfl0uewS61ky8DzlJJYLapKGBdYO9AaN7oSkt1T56A
         /jwbs0Ni8GTB7sW90yi1bGPuC21ORgZmgfXYm5hLd0dhkEsmVn1r+cLxE4yn0egT5/vw
         g2P2OEFUFmeIqWTn/fxnD0yBHbsi/N9X5KB48TkGl73eMn3oJA9ajfvIbXK6dxjYJyu8
         O4T7M7xHt2nGlEpbCiycHbIlbX7OEWzY2mgPm9pAFpHT/4nPDl6AXFAT4X30QV+0pwfv
         s0kA==
X-Forwarded-Encrypted: i=1; AL+hErH8a4a8KLXd+i0Ey2T6KJ4D5htkxeZbzC8TF1gYOkWVd54kebZMLYVAezD7Z67speBuHg23iA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9sl1zf0laPSVkRPn6fB7XdEQCETPTRdnhM2RJDEl6lZrK/itRE
	WmGF2UcYDm77+qvKqAAz00RS8hiTVnvYa8cmaUBtpy8SCHgZK9QL73ot
X-Gm-Gg: AZFdTZfUaMTPg3u4kHrwoN0CQ8fxez8Yd2U7fVn0lEfVujBNiemVkdmZw3Pz+WyLwyq
	ULiD9t1YthPNW1uNwBPw+tF5OpgxN7O2fvVO8V8VDsLEjF0+t0w0hnywFA+yxOzv1nBuqoOHz1t
	iWIgML+l4usH/v4nv5JMiicJrQfd1ZIoukJd8WtwDPvRC6zg4JU+1UdYwTt1pvM2Y906QQ9f2IG
	yWxYnqHXoHXqsTqcw+lgscNhYRGi15LeW+7fGYQ9F3JqfgLVbVEYLYwQM8ir2l056h4QAqYHS82
	uQlhVGGEWJtcsQ5h6cEXZFw2d1FnjFbDiW3tfbj8NR/4AtVi0LUsdh8l3l1VLnTr5RLEgntyjV/
	M7YgGHDCXzLKO3tynMPsawP1ymxUZuKWpq2O+nfYabo+z7NqUYCliVGJ1wAyqgKl7k6T9D7XqTS
	JrthNQz07DWCEOL1EmfSaWXdRc1HUuI2hjNbfou+8KoJCCeYNek/XWTg/6cojq2U7xCY0OpAaXw
	NcbESf2Ur3TpnHalKMiz4f1d7JyH23FW/+N0D/XRRiGbApjwZiVC+XFtrWJqbOd7nmN6wXuqTRO
	I+rVH+FLya80a7fGPdNFt1NjuNJufBZR4KaTND8kNV6AJjIDvRXz/5YZpwX03tKuxk/OfvGCdvl
	GS/NhJv1EiaW2DQ==
X-Received: by 2002:a05:7022:1587:b0:1b2:6d5b:36bc with SMTP id a92af1059eb24-1b5568efd35mr13570989c88.23.1795435369489;
        Mon, 23 Nov 2026 04:02:49 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm27453682c88.15.2026.11.23.04.02.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 04:02:49 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 20/27] mm/damon/api: introduce user_report report type
Date: Mon, 23 Nov 2026 20:02:34 +0800
Message-ID: <20261123120240.9394-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-21-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-21-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Nov 2026 13:00:04 -0800 SJ Park <sj@kernel.org> wrote:

> Users could know some data attribute information and willing to provide
> that to DAMON.  Introduce a new damon_report_type,
> DAMON_REPORT_TYPE_USER_REPORT, for such user-provided reports.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
