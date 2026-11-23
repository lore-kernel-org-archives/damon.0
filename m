Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435189;
	b=EGyDz6013gNkUyqwZiT4qi+MnweycEFI/RK893qkKWfjIXryjXxvXS4QC8KhxCbtZsv6
	 lfc9mYcF/HfIfA03UcpSvni6i2AgOuNYZ24P09cOGRBC3CQ9BLR0OZS6tHpkbSZ/KHjwy
	 zxQfDJaJMPsPRKbzRK906NkEl/ADfXHXCE/my2IxrfI6pf955EEqhTJ8TRWr1CNSpgFBu
	 iKKEvfH/aMuRqGeuIxPua/N+xs4ms1RsBiXCxS7/qfibDeNNfU8cvymKLrpR+cwjjq73r
	 AiXkg+N6xMKrdQ0va/D+27tADb1uFONT3qnysBfJpX89VNejXlLwkIy6XhI1HIMvcpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+/NLDk1vGGl8xgKid79Up0qMX8cqYam42gWr11Gs008=;
	b=xFekV0CTp0j4Lspj9aO05NlVDdm3ruyckOk0JDPcBVVwNDkVO3c2Fgraw8GuA37Fhmy2
	 XU+/QASnWaO5qA/VseDe2CbMFIrVZdjNWj/6b584NBkfuJTlqJtupmmwhkugnkSdtJFqE
	 gwpcWdm56jJaMFDpWqA0uy5ns/1bDa1PF/CUv/BvJMuV3xV9ghCXNEfz+YMRAUirbjLWj
	 fnZfhZ9+NGD1g/8kGtk7P/ft7qFo6LVX+V1R9nbYVxe/mGfb7aA+b7MDNZA4JryifSkeW
	 gKWZyy1oEhw8X1E6GooDAsQyDSK97qZuOx77Xd8FB7KBQZ0h66WynUluLd8VVh4WV4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B8XTPmeA;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8A606A331
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 11:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CD8A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B8XTPmeA
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3869b68caecso4090180eec.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 03:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435188; x=1796039988; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+/NLDk1vGGl8xgKid79Up0qMX8cqYam42gWr11Gs008=;
        b=B8XTPmeAWZHj8PlWR8LuzwfZXEe16IyTizXcJP3fR/AoDp6mjpU/gx8IapscGsnpHO
         urBmDn7i15FbVbGyDFGVgTpyOvu8U16aKj6RRM6tnKi0fezpcsX7xkPzuZNE27XpqICj
         xp0L1pivAPrGeoOubcIAbKI4oRhJ5o7oyF1UsOqft2U77HWGY3jr+Mtt7e/dsPcHGqXc
         lNDumOLXC5tQVdWvFwnwD/z+dgH41UA+1ralBgNqQcGkcSWJCc4orQQKaf3FG9DOdwGQ
         a9TpPi2Nqnr1fi15F9bBT3AUjKFS5YlItCyJBZMxRzzkFyKUHCsLELC59WhVJxVyPjNG
         Qq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435188; x=1796039988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+/NLDk1vGGl8xgKid79Up0qMX8cqYam42gWr11Gs008=;
        b=sZljUgY7EaEAV6tG7en88m2GLBGPKbxE8SX3SwsRpEpblpkMrp50ZlP4sKXrS3SJ6e
         EK5usOLFxRkzntyNeeLX9Pb9t42ktHgTS738qhvvSdabdEIrJ4DkHNYT+hnyOfSbp1FA
         KwR+P7PGseBQ58lDrTFDGA7zCP9ACLPXlCrn3B4lmOQYekJv7aQycNnO3W4xnqT+AILg
         XIknSPlggPmcM7Uq24OxudkCyHGSTHukFXtP17Q9lJny2ITp2L447VbFh2IU+gQixdTB
         LgXFx4E1M+TeLDGrW7glKqVs3hesN9WGQxTFNX6pmniDVgqOfs+lo5HzTOQY1gYUfcCz
         o73w==
X-Forwarded-Encrypted: i=1; AL+hErFbxnst+w2BZg42IrUOba/bcbSMcw2iDlDm8NbQe4Cbd7kOKGVrae4JBKn9Zw0RL6iXQrKhkg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/8Ts/B3IOAbuKxNhQSwDrH8JlnD6RRd0VHmLumHUjW1sR1wL7T
	GbTfjJLD3zoJIKwz1ryLuWAwDbOkO6MnzSkGTGnr1Huh+L6LYwowcwpI
X-Gm-Gg: AZFdTZeh+EiOita1uMtxv50sREillqF0E4KgkjJ6l8gzRUloOknmG0MBR9EIhBbF2+C
	aSDJap6RcqcHTu1zI6kG2vUj5+D4WlHBg3H9Zbb1PdXnF4hwG69pEDohVgNGOc+iilUQoTS6H6N
	JFqaWF1HVXcrB2EfGYnulIhBTNZgrYmrR2xy03WWWoRW0Bni+LmOSvjxwBJbkm+sj6IacIfzS69
	PxYFEd4uuO90zBwPgq3Yl+Z77dw+Tqdaw38+Cmc49xbOKD12J7AijqCEbdLEYrJdaaKZid6Pg91
	B/M1omwkuG0ZMnajyA1tf6BBtl4WPJGBTizFI1u94hbkkNSjlXl6mq7hiQHyQnD39v9evM2rgRJ
	x4LILE2iApHr8KJe4e3qIMfUD0sLy6fiKslurm49tR5BkBXdHb0Jsv8EbeQ/fUvx0WasfZwU38A
	e8lG7ASxH8U9vtgNcE+P5chBGS/lz1n+Lhdob8nYPXLkpMSzKOtK9aRqxiYNsNCkypVkPACeeGp
	moRuBwwh9LOc4yOEOz/jxDYoxEPCzSBqMJjxYYg+gmBPiW55jce2Xr57tZV9Z2+9BvU2eEdGcpr
	1JSQYtZJe0geQ2g2Bs/p0wAbtvKBmPqbN1Q5HrJMf4WcSSoqJgywyIyxCy1mtkMOCjKF
X-Received: by 2002:a05:693c:6010:b0:385:2057:eb95 with SMTP id 5a478bee46e88-3857073f2a3mr15247386eec.31.1795435188390;
        Mon, 23 Nov 2026 03:59:48 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm37620267eec.28.2026.11.23.03.59.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:59:48 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH 12/27] mm/damon/core: introduce DAMON_FILTER_TYPE_REPORT_MADE
Date: Mon, 23 Nov 2026 19:59:33 +0800
Message-ID: <20261123115940.9068-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-13-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-13-sj@kernel.org>
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

On Sat, 21 Nov 2026 12:59:56 -0800 SJ Park <sj@kernel.org> wrote:

> Extend DAMON probe filter for the existence of data attribute reports
> for the probing memory.  Define a new filter type, REPORT_MADE, for the
> purpose.  Add a union argument for specifying the type of the reports
> for the filter.  Update the new argument for the new type when new
> filter parameters of the type are committed.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
