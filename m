Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748583;
	b=kQT43C3ax1vbs1Lqv7/azVtfJghMfddnSGdIGMDFXW3CWTYRJEos1HsFQqSpJCHlmQHq
	 ld8wdO+hdS7rDaJNvekbF4cbUnFeNiSR3G+K+yXWPWgS3rIdWODzK5+BHdxIvLE4bjHzo
	 76GGN5OWpNcLVnFwTFdCbI+ez2IYdKa0EhtVgG1363h6qutPkD3sHDerPWjMZYEF+cGRK
	 peg3PnOc5nv6QpqINx4EQK993GBLCkwYUm/zsfp0FM+tLLhoktUU2rdEhp9tCnWyYffhp
	 EOyB/mFciS+IgYEXHfxB7BTUn8HYiUz5e3zkX4mOOCCRJjioCroyEo+KYdQlEBImtXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748583;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=wpmEz6SVw1Pidd87JGDfgjXHfjdwOXEDwvQkKuJh+Ls=;
	b=0DR10fopam5xjgdbWXvKLmO75BjFjcKuMUsvTYXguebbopFVM8qkneqLT0RU6wRiTQgK
	 czfiP3HpySN9j2zCwatdyHPGfKoHsv1JbA3YDIYXMo1FarHSHeMITlNl9DmdJuga7q20w
	 PpFI40uyix2Luv3/LgA8Zz9/MFNOx3UGVkKRzfylFdEVDKLtCbUm0MCJqb96MnZoUjULB
	 fVZsbTPd6EjXzbKg/si/RRWiwPuk3JbXuqCbjEzlAO9W6tlVyyUuCA7qseIDed8S0vdnw
	 M2mUdgImwFKeyBOQ3R2dNVd/K9V0hUkaQAtsYXNuYsLR4kNVcnVvXC5Qepi+ZBGl8Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Xu165m2S;
	arc=none smtp.remote-ip=91.218.175.180
Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB3606A31E
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 03:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89BB3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Xu165m2S
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=TMg4zXV0ILXrIqCuybjN+P1zkyONhZoSv1Tpf+i+AlE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795748579; v=1; x=1796353379;
 b=Xu165m2SZ3cMtkKCUF85zVIOxqRmKhMgt6u2iN+5e8v2bc2gLILRBvJwQnU6KXeBb/2dBP7b
 g/f1cE3WJP2kars7/H8EMBDHUQdfNMjblgd3VTqb4I0JkwgD5aWJVG2v+1ibvnZYKWsCsTrzAog
 xeh3WwAdobvMduvJ6mU2WSsI=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 4c9688f63cfabee9;
	Fri, 27 Nov 2026 03:02:59 +0000
X-Mizu-Trace-ID: 4c9688f63cfabee9
X-Migadu-Flow: FLOW_OUT
Message-ID: <dd3c5a28-e7c3-42ed-ae8b-dd714665503e@linux.dev>
Date: Fri, 27 Nov 2026 11:02:55 +0800
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
Subject: Re: [PATCH v2 10/27] Docs/admin-guide/mm/damon/usage: update for
 report producer sysfs
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>, damon@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-11-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-11-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 23:36, SJ Park wrote:
> Update DAMON usage document for the newly added report producer control
> sysfs files.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
