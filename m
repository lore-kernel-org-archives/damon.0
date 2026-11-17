Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908625;
	b=VKHkZ/y0Oa69AVsNZ0xE9FUEv7dvaGuiS8Xq5elsLscexCkLfEFMryhRFIHg6gqHbr4h
	 h8V/0tpnRmyIN5+TzvCDOBiPSwSjB2ut1oe7nDcDhC4wh9hStGrwl76B5cuVnkT3dRrfE
	 LrBrJuxVwK3VocptkD6Wj1FZ5GCY0Jhxmxdtn95o1eOn34hZADC+cfP38Jr7N8JXpha27
	 Z/tH2xeE/OCyilVus5u17rFki8Vr/JCZWYaYg6KMKwa2mbs7yM8q6qQlbwb5/+tXzAflY
	 4dQhVmaAPjqXVyzhqguZgB/ddfvIUVtjXoWiXdEgfSiCFA0E+D1XaZ/By8NbMvXgHgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908625;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Sqv/SgQ08rWFoJUPpiruSJD4TJXVLiHEu5SvhVq+K60=;
	b=qyV0J0BqgiqzEoJjUJVL5aqGWEMPdTR8IAxeLbd/UR5sLAzJuv1QhfZqaW3X+fE7sG+a
	 NDqrr5PtbXTcSuEMWibBLoZod82dYq66DsXXYQTupbP9kPDNiQ8jvT36SDjthFsmoNZPg
	 VjR/DFgunhZLqhez0XQwkeYxzOvM6Ri1SDQwiN9n7neVCGHrwMbSis0kb99eMqHYFu8GS
	 1oxr45p4pZ27IS7JNB8bV9CWYwAgmjS7xv1iWldNq3iG/rV9mL1SNzzjYiedZsDu7LNni
	 gNCRJnSb+xAqRTiMD3ZrRwyowzU968idD5eqHjH/xleOdlRa+QDheECiLmlvTYYjk8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vHjPXR79;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1715606A8AF
	for <damon@lists.linux.dev>; Tue, 17 Nov 2026 09:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1715606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vHjPXR79
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so18663305e9.1
        for <damon@lists.linux.dev>; Tue, 17 Nov 2026 01:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794908623; x=1795513423; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sqv/SgQ08rWFoJUPpiruSJD4TJXVLiHEu5SvhVq+K60=;
        b=vHjPXR79I9AAaP3HQwGsRjcQFWhwhMVP85zCv8ywTHQhGQ6LKFFF2sJr2OcAoge+U1
         t3kZZB7tXRVArdhwqmEO6LjT+oijLlYGkyvOaOU5nt4Mxu4KZDhQiQhUYAVJMKHvcLT9
         H8n9eQ1rLHh8R9tLP5y4qKtoU9Jt8203NGhASKa+CqBfO5CStuuTYT8hkYT/xbawh6cN
         dt2sPu74uwHfhI9ASr3HiG8NCRiG1ytUzChIWfNAvWIfBUAhuFyJDUto9ictPr4mP+YE
         UlypxgQ+G9e9/lCDgPn4O9sOY2mCqHQn1ZvaZyag0rM2LX+k135DmylCu5TkkXzLJsBT
         ZeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794908623; x=1795513423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sqv/SgQ08rWFoJUPpiruSJD4TJXVLiHEu5SvhVq+K60=;
        b=Vb+5N++O5CvtDMeDHOFKEV+6cxc3dhDxSwGaq5TUtcidxqWskd6T8JeuE9b4zKYn5V
         ej660mlz+45LWs2iZu0YuoZNIFIGniTOAvZKXYewtDCsWse8e8Ej/hBTmWTaKOEoW4Z0
         WpFlqLDTmoJc44tZ9H+ANedxW6rpNApKTTVzObnCcBOWILcjEgI0Xehk/fcGg/sx2ycL
         jtqfVvgDoOtxPfYDJN9aYMJrK/l4eao1ePX29tii3VAMvhyVRGIOoCu85MllI4E0z5y/
         Azc6WQPopEODxe6mVOzMltFKosaCE/0oN8CNinEUGc+/XJQyLtM+Lv5sYf6A7yFT9zxp
         6Axg==
X-Gm-Message-State: APuU4Z9qedKdHZV5vAfe9mpMO5xQME+K7qvQVpV9uxvjPAZaTHjTSJDS
	GWjX16TslUbM6dCd+FaS+uH+o4N//k/jtQI7fEzBXyYXsw9U+KrQpqku
X-Gm-Gg: AYBFou0qb5juSlqsc6z763vA/8Eh/peMwVM/FV1z8jKNzkYHIrAKsr91Iqug5nWXe93
	ASeWD8VYfV8WhK0+MIDTb798RRtBRNr1ATq9Ma6DkfLs2nGtUq8SN3PXRIUxM8fRyEocZoUbYyW
	YaEwqW18H5gugpYNE5MEnDtMkcyQEk/I4+0HANxCW1qUnESpZ/X6srVNp3+9IGiiaK/fDs10K7f
	FFGUi0rlfqdFh+K4T5VcS1f8TBiFJvBXZKpwuAy00mo5fZcaxGJZwI8CVDXW2vNhtT+4juMNdGA
	tS0G9aDXHmfg+XffSOXBAIkPxP2WudiiF8zFPDFXpYNe2a0ddpc9txoJDZd3HwHbQyNTT1//Jos
	BVdLUmAzmWKQluQ4OWlh5npEaEwHZeBs03i9PLXNJ0wVD0E0Cf5lWfMycjYR+oO8kbtoCDUu2UM
	RWPmrOkvOuVYb7yNUKgPuIhLQlY1eSaD9yJ81SoHlZBhY3onKysVRKiMEmg4w5CCLPqvVB4aYi9
	ZSUTGw+P4OcbwXPy/4rmf25AyExj7q4Zsla0xbhd7gStVrD2lchDSdt8f+aBpASsg+0j/YWD3IP
	WV8blWssJkRY0eZgE6MN8kqRWFQvvvo1twrXymB5fjwFK0ZKcMDsiuSCCdatdG1yLE5tyOKf7sB
	UtztTd/SphOI0aeyQP90x4HpMZyHHXgA3Shc=
X-Received: by 2002:a05:600c:1c0e:b0:4bb:68e5:b952 with SMTP id 5b1f17b1804b1-4bb68e5bb4amr205720385e9.16.1794908622593;
        Tue, 17 Nov 2026 01:43:42 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7ad96096sm16212925e9.9.2026.11.17.01.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 01:43:41 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Aveline Noir <jm5905938@gmail.com>,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon/stat: avoid 32-bit overflow in idle time milliseconds
Date: Tue, 17 Nov 2026 09:43:22 +0000
Message-ID: <20261117094339.30978-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
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

On 32-bit, the region idle time in microseconds is computed in a long
before the division to milliseconds. It wraps once a region has been
idle for about 36 minutes regardless of the intervals, so the cold end
of memory_idle_ms_percentiles reports wrong values with flipped signs.

Do the multiplication in 64 bits and divide with div_s64() so the sign
of recently accessed regions is kept.

Fixes: e5d2585d9e85 ("mm/damon/stat: calculate and expose idle time percentiles")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
Ref: https://lore.kernel.org/20261115173343.82437-1-sj@kernel.org
 mm/damon/stat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 6e05a2b067f2..f2387aee675d 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -130,8 +130,8 @@ static void damon_stat_set_idletime_percentiles(struct damon_ctx *c)
 		percentile = div64_ul((u64)accounted_bytes * 100, total_sz);
 		while (next_percentile <= percentile)
 			memory_idle_ms_percentiles[next_percentile++] =
-				damon_stat_idletime(region) *
-				(long)c->attrs.aggr_interval / USEC_PER_MSEC;
+				div_s64((s64)damon_stat_idletime(region) *
+				c->attrs.aggr_interval, USEC_PER_MSEC);
 	}
 	kfree(sorted_regions);
 }
-- 
2.55.0

