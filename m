Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.143
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795876470;
	b=oHV1hvlLjdgTwOFiEAGLTl4rUxMe+48ZnbykuOlgGBxmIqCEI12Qjc/3yFIkETk61f3F
	 je/vE1WIvY9n1I/aUZAqPTMzPXu8iuiRjcE5In/C0r3J/060JpfRGQ+rQHulohYQTm9x1
	 DOvWDIYyB9ksGE2iAt7QJEpFo0Atg0FDf6a/0MF8MY59LsE+eOr19cOJAug7JtZ6BjfNV
	 X9JS3TpRLJH/07vX6O8Glxf91HVAGtHUNyNPo4cTlpknJa3RxeUmB7Mfl6K+w05CI9NDn
	 fjNar3NKBN0rjxSS/m0DtWmvR0XQ+zmUjvq03YKLCvuIdB0OYvz1TKnJLKaTEdR15sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795876470;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=+G1jLcr3134Eux+nXrQYFILdYqvnyXIGhQVTAS4PcRE=;
	b=A80G0jVbbQM0F0zJiAOYTUOv2Xzi6czVSIxJna5iZzhATML0BEZtS5ZXri6NaEZz4GW4
	 n5scaw0bEpRGVeWn9WE8HupP46+FZW5P15nNzyVu2MOWM0gL1yWjNIoM31Fy7F7D1e1Z0
	 SZ23wj/JtNHFdw5zaEGGzlAlZn9m9ZBiZBkH6lSn6atmRX/fb7/PMkY4j17aakmhWnK7P
	 pe8HKVOwr3JuxRsYKlhlPrKOAAU0KUqsNRbING2ZD0GEQdIQcpyFoUX9um8Fyf0eljp+5
	 rFvTna8hxIwRRVnLLoMjn2vKRRx4ln7KIZzX7QRQmA5K522j2C/121OVAVPL3zJP4LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NEuLHbxn;
	arc=none smtp.remote-ip=91.218.175.143
Received: from mta0.migadu.com (out-143.mta0.migadu.com [91.218.175.143])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22487606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 14:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22487606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NEuLHbxn
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=OGqZHTvCPGuSQx6d2HorrF/8zb/bM/HvqnkBfl7o0h4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795876466; v=1; x=1796481266;
 b=NEuLHbxnjRMdyxHYT4ExPEDcGGUmF4zp8boOnW9H/2pLWDMO38t5JKPiojgCYOLZn7wZU4Yt
 SveWHD4dejsmtvrXSEedjB5pGltRtjrfhYxcU6CBhME55thLYb9Q9IqorpWVEKI3Tw8Alm+U8hu
 tCZf78/UfSSHBML1keAPfCv0=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 4f2e8987d2a0524c;
	Sat, 28 Nov 2026 14:34:26 +0000
X-Mizu-Trace-ID: 4f2e8987d2a0524c
X-Migadu-Flow: FLOW_OUT
Message-ID: <fd32ec26-d66e-4539-b653-2f0f11662638@linux.dev>
Date: Sat, 28 Nov 2026 22:34:19 +0800
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/27] Docs/admin-guide/mm/damon/usage: update for
 REPORT_MADE probe filter
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>, damon@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-19-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-19-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/24 23:36, SJ Park wrote:
> Update DAMON usage document for the newly added REPORT_MADE type probe
> filter support.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
