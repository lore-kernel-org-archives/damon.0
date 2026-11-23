Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455481;
	b=F0o01UnIKxIFQVYA8Ionuf3JJu7qO3THt1BbV3bhYstgMlE7fJ/gPAqPRL6vTrZBoANi
	 h0/6PN7EopehWZ48+nS7bhplYtJXjrZAC+kbqcW8Kjq/Pm9a/AkcUW3aYWLRj1R1Sp8Vo
	 ndKkWmVT6zx7NhikxZPm/lMCoMOCLr+y1849IuMu3XRVpwRON1d6ZiroY0SbrpMmlirw1
	 70KX8pm1ZzW4IUD14IECmcDmsFgmVjTPlxofeDWzIjeXq2BapAEGnWi/QM/Gca4IS7SGP
	 W5DhI5BG5RmXeCpZ1PBQYrYjfmQkz+T3ZWdORffw73FQhm1g7ceARHt4rHIlE0qYJ/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=GdeF4xDXe9TQaYIgdFh4G15+B2cWd0mkAefbmf3E/zI=;
	b=O6sEF/Kdjadp4+RciMcGrFblo7KEW/KukhLBQwe4dxAurT2hGtfFAR+09+F27gbLcp5l
	 TLLIuEApAeuPF4D6kCt9Olp7JGk5hiimkr7a7I+h3eXln3iAOig2iaP5YVnGiQMqI4n69
	 AQNYYAlBkApmc3SK6Zi5epNyXv7ewHHCRVIP0FMAeUB1K413bMP3n7rLG/eupP8WOTHEE
	 xjP/FFQfph7jPKqHC/vbdsUjUyQzZtauaHw3RW7tsAbLuhrHNnIxBne7g1jDrATia8obg
	 U/JPgCz9otFzpZxXySwO/U4QXQeBHHZU6CPv9BfMD9cEa46ch1J683oaoCKWn2t4cVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J7lEl++D;
	arc=none smtp.remote-ip=74.125.82.195
Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407F606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F407F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J7lEl++D
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-3869f03af6aso2696330eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455480; x=1796060280; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GdeF4xDXe9TQaYIgdFh4G15+B2cWd0mkAefbmf3E/zI=;
        b=J7lEl++Ds9xescorxFeOscV1c42JD+/0wBgfToB7iaPRe23cmDcdozCm9ypRbA2HJ0
         d3mFNT0QrNs4NsmMxDu2tkphL3leHCSH4mwECRhQV7wPoHCQGSJqMnbGCFgkq6Vubx4r
         M6Wt+/zS6fSPii6COCNcJMmOLwYV8iF5xUursiNw4n/hC28/bp0cucmiZgNlyfL2T18m
         eWdv/5QZi1fjj1wBaPnCCfxw61MuvxRRN/TAYaUSXkJjzG4Og4C7np3WMfsQcFoy4yaE
         LB8oTTqciJrK9Vo1OmODS8Vr2dmKhetsONDDjQlNSW4CbR53BmgqejVEFmjxHdeO+2By
         dCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455480; x=1796060280;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GdeF4xDXe9TQaYIgdFh4G15+B2cWd0mkAefbmf3E/zI=;
        b=tozTGhpDXIar04FbvzsjicoL6p4OMsuT7p5PXOtdrtEZio+MAVC+FithE4baGv0Zzw
         BqX3q9Tcf4XBEJ1/i51Bj4AGPYxfVcp90trlQz1VSuvaSVhqxQKwmrZ7ifUEDmmqIfta
         1rT9B3V9ZmDWZCJlR9Q3SBZUp0iW7iEQJ3dSfwl8hfoEM8eIvTqICmOwetxShhFD8DxF
         mw0KFxcnhaS6VP4+IVlYXnKjlHAcoWgEKnkHhj/Ymqq3hD3gqZbQHj7R4M60BiUXJe3u
         5vrmIqYvEIS/ebbVpuV+hF5z3XxW3k9/BWbKiJFG+dv1is1EidcDbnjPcS+d4ip4HtLY
         7Vqg==
X-Forwarded-Encrypted: i=1; AL+hErFyV0BKFIP7qCjNGzMOFzh4saMHVy/PShwzn7MfUToXzFBtf1EHCCWMIukOti62PE6E0YhSiw==@lists.linux.dev
X-Gm-Message-State: APuU4Z8+uV4Pn1Hl0Hxds1JtQ/1fccZ1r5vTW4anFok7jLtZpy7TTrFL
	v088NO5CC53bVDXtX9rC5UeyrtGInYc4eOp9W6zmtsCwEba5jTe+F4V/
X-Gm-Gg: AZFdTZe8MRyQfFhNJipCR4/Z8CeNm0SVvo1AykWPBzGwCrAZXhxcPfl/X8v0UPojNwp
	W6/IxB4rteNyRsqVWuwc6UclnDQne1INlpYISaKj8DV/NcNXDnbIBH8DDVAO12Xvfq7QkZfd16d
	evycYP2Y7Bq2WUR6z9EHaP8s0QnfhYP/uEIR8L9T7ra0kefVvS2gxBeZK+lMHLrLy4anqDSm/be
	7WHx8swhEfbLNVHwIt1AWnoQOcRv63Oj5R7s0UH3cSnA5psdJJEUj2jEB0RMdPIgLWd/JRcNyjG
	+hxPc6+x7EdngoPlgrDzsARJpG7G/XelTSzTVXcROE/1vK3TDHw70DkZOSm6bFxDSEG9J/ow9Rc
	bYbI6XRgijZBv7HMit2/Iq/w1n/B+DUYAGOk9/y3A8RlyIiFOjCTZXM6pXUBeEeEkX72Jci3nZQ
	f2i66uFbAQ36A/VmaDAgVuW2hgv2UImHOz7AXli/4npMqu3P8Zia/1HtfvhBS6j9HMg0mCdowpu
	aZP3BlliLoFZy+9Er+yFG1ia3DbDxmqYpFNfxZndKg0WTXxTAO2OuqJoQFTqvsa1F27kNZFgkZX
	bqGTh51KwxHsBM27Wnx5bLnhW6KW0hcFpFUu2VlzRExHFilJuHT+eI2UeZ+kgeeL+m3fx9PNmnb
	T9H7r1nxMUd5qkjuMcuhDUb85NakX7zFMBjaZecIr+8Lcwn6slml+En/eBprbYg==
X-Received: by 2002:a05:693c:25cc:b0:369:f17d:efb with SMTP id 5a478bee46e88-384b3e77699mr19708498eec.10.1795455479865;
        Mon, 23 Nov 2026 09:37:59 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:37:59 -0800 (PST)
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
Subject: Re: [PATCH 19/27] Docs/ABI/damon: update for REPORT_MADE probe
 filter
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:24 +1100
Message-Id: <179545256493.4.4781615741827867830.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-20-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-20-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 13:00:03 -0800 SJ Park wrote:

> Update DAMON ABI document for the newly added REPORT_MADE type probe
> filter support.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
