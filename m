Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300749;
	b=CPyJ8c2JrphIcamu1Gvb/v0jtzLetK/PKeHOEVwvoIPCtDaNFJ+i6U2hLrydCmHTaOSX
	 ZTqLKrLzom/t9owlvF/3nuLAhjhAkpFj2BTPyskRdysfYrKVEKijt8Du/a2UKbO1bTWEH
	 KgtG+zn0E2wpiqTqxbhwIgxAvxbTzml3vnqWu9QrRcppoVS6WAVaV/ctdwkxRyARItlNk
	 RzrdjfuOcHnaKlzTVw+FG3hOHjKKLeH4xvkLYmHznD5fmsK8foMOTqU8MEhSJGHcTgXQe
	 y5S8UEwx+0t9MfIxI0qTvoeuI1y1kU23/FN8kaS44fj5a6iWzOjFk15QTA984SW/e2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xfIJPZ8iDuwMd4fEVUhcFpuLjx5VOiQMHuJ+5IFm8uE=;
	b=dEnaipJaf8CoaXRcJqDJhI4wumOw99bCvr6ZVlUq9ydH32tTgkH71HBu2T8cpuhViSEA
	 X13HWQsvOa+kLMzo0jPUrFe5oRY4cYIJCWNvRbG3nufuchDiRA3m7uJUpnHEn4LErvnIX
	 1Y9pET/XTABIntKkZ6LwlYjm/Th45Js5FRWOETsdPh+WVOG3CNAqo3AR1nLT5PNan7SeF
	 dmKlI1IAfumsrDKcze7Rln2mfpaSXEzFUuorYEoCuHXR2VpYWUm4aivho9KJ/V4XQsavM
	 K0uas1K1igghxciQeSie0FPe/MZdm6rU5N4SvxFd5WZUaxS0P5f7h184TEj1FtQHS4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PqHIFfwf;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF20606A31C
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 08:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FF20606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PqHIFfwf
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36f8cdd30beso2383608eec.1
        for <damon@lists.linux.dev>; Tue, 10 Nov 2026 00:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794300748; x=1794905548; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xfIJPZ8iDuwMd4fEVUhcFpuLjx5VOiQMHuJ+5IFm8uE=;
        b=PqHIFfwfrZXTungCrZl/u/6yCXajmwNNpeI+VpGTuVtNJh3vTkVpk/KLrkEGyjNNgF
         qlC7HrGbPZx1jU+ASqetMDHnbNG4tLzsaYSgGXBvcuNy0y9HjG0T9QCaOvYZ7GdaYfth
         QvmZFmCLRO74AoLfrB0uEQRJ+I1S+ZwS01l/x/3VTumUHDYDpP2w9Tv+z+GP85aGMUPr
         Bwscd/OmLt4hDVrMavDu9lU2d9tsS7baOiqWfN3V6BdQ4L+mfgqJt8OFx6DqaXoPTDhY
         D9q/YnMJVtkBpDjWC6BXCJxFIDMc+jZ0j6IY10Mg6WEZ/D8GjOqo8erU8VjJjW0n8fkM
         h6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794300748; x=1794905548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xfIJPZ8iDuwMd4fEVUhcFpuLjx5VOiQMHuJ+5IFm8uE=;
        b=n3f+EeL39axKEk7neKygodk/+IU+4TNLNFJAuxsb8/EmaSI0pvCpHEsPXGt+FzOBoZ
         ndAnm5sIHdF1xMhUhVmdGFpTyzCNuvDsdAv1gySwWd3jr+Q+mtDZM73Qf05RfLTaLJZc
         +dRMKj2j5/zqQzBdwDZmI0LGWqh89tWRpKXZ5Ne6k+6uCArXsJ4qIjZPXo+rw8zU7YaX
         5KWn+Or3/Bg0vwJRAZHV7fM4LWix6MIkauQfrmRznxTPwUMFiFriJfb085BeDFNGzwJA
         gN7rr7Fpo9qzguujg8WkbxLm3sXHzLEdhMiaLl2+JDO6c8IyGTwKOyEsM+t64+Ib052c
         jOdg==
X-Forwarded-Encrypted: i=1; AL+hErHvuFWY52SCO9nWxdDFFw20z9jLGEOHX7LJ7uNV6U7asWk/joZ48jLxJggraP3ofBkPXiQ+yA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8xZh67D5633+LkhzH4MsmVowPKN+X0i5CDqAXekPZbTc+W/RMj
	NdAPtobfo/FgmBhuOo4q82GKTOVMKEdEWFzWH9ZjpCmNbLSRO9kExJL9
X-Gm-Gg: AYBFou1D3yaJ4xt/Es5E/d2pYpKn4/C4pDyEgaDM/Vw37WD+7OJw+I1xDV1JQRrGg0T
	rHfVZQnzEqnVQrMPJ9RGVWuxjfI49IofGCbF3xmiD8rSuN033oZEnz4UutvN0TDQfAeAPb+OwsV
	dbD24rb0n+execzHvbp88a1kljl/OPyaWOh5Egu4T5ZRocYvYFlbv3K48T+kYs9stIBzUlapgnc
	8gdqRmzvYRDsk7oMOnd4VJnV2gMWfQTik2SkBe+IuMjE1C18CkikdQyQI+N8W8ymD/OPSzjF3HD
	K1RWqvI98IcA2ROlFUS+SIw0gR15It/uV9V84p8t8kTdxBXoE2YseJofrk7jLC3tCrEjTNpYkAZ
	GMEF9xrKze/FCUTZ92w6f9xHrifD52HzKCZ9Gisy+4QGEdb51EN6igs4AMAhdMupIgaRO/ZO6m3
	95qsNfBDE0FQCAVfWLkQH953CHkpS9pNmlI/pkp5r03A0y1/ElUAHdLThdMAt0GNUgqpn5DAxbK
	VYzV6g6Wx2h/Qm19eo1ShbwpaA1QsSX887z/tggTGfaCVH3QMDTiyDbpyF0kmuc/x7/UGy0FXpx
	KzW56b5UUOtPvMxoWg7eY5xP23+kykYqA1i+GJMdV0KQ3bApZL89FBQuOBUstzjuHKPprsU363j
	X/Df5wTsr8E2RGqaO/33yDrF/0+oygKP/AR478T2ljp3ewCQ=
X-Received: by 2002:a05:7300:f48f:b0:351:2958:1740 with SMTP id 5a478bee46e88-3751fc35f80mr2396611eec.37.1794300747995;
        Tue, 10 Nov 2026 00:52:27 -0800 (PST)
Received: from AHUANG12-3ZHH9X.lenovo.com (static-ip-10-78-56-61.rev.dyxnet.com. [61.56.78.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375215d8889sm5590830eec.27.2026.11.10.00.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 00:52:27 -0800 (PST)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH 1/1] mm/damon/core: simplify minimum watermark wait time calculation
Date: Tue, 10 Nov 2026 16:51:32 +0800
Message-Id: <20261110085132.1023-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
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

The minimum watermark wait time calculation uses an additional boolean
variable, init_wait_time, to determine whether min_wait_time has been
initialized.

Simplify the logic by using list_is_first() to identify the first
scheme and initialize min_wait_time accordingly. Subsequent schemes
update min_wait_time only when their waiting intervals are shorter.

This removes the unnecessary boolean variable while preserving the
existing behavior, including the case where no schemes are configured.

Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
 mm/damon/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index d36823f4d092..93ec684a113c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3985,14 +3985,12 @@ static int kdamond_wait_activation(struct damon_ctx *ctx)
 
 	while (!kdamond_need_stop(ctx)) {
 		unsigned long min_wait_time = 0;
-		bool init_wait_time = false;
 
 		damon_for_each_scheme(s, ctx) {
 			wait_time = damos_wmark_wait_us(s);
-			if (!init_wait_time || wait_time < min_wait_time) {
-				init_wait_time = true;
+			if (list_is_first(&s->list, &ctx->schemes) ||
+			    wait_time < min_wait_time)
 				min_wait_time = wait_time;
-			}
 		}
 		if (!min_wait_time)
 			return 0;
-- 
2.43.0

