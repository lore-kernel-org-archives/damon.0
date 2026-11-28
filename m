Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795876873;
	b=cS7tAFUahyI0Yr6B2ZkC91JYTsYs98zoUYdG39fQI5UrnfMoPG5mf0qV4VbIOza6dJGr
	 drardO2roB1E/2mR0q+CBK3SfmgdkcOT22jSwMAmYUdgR29TBtEHNTvUHeq2+elO8sSdI
	 pPAg1twxg5bt8vaOeszZ9wb6TvgRfgGwsWauEwtQUk3l8TCXAbbjR9ctYU31LQNDacPc6
	 CsGrTBiA67X7TqWtazalqGbXOcBwqcNQeTKkLMnok2SgtoqXs36mzJfH7tpqYULoqzFq3
	 ImUFfyhMlv8WRyyk/ObtiJxXc2jSzRjZ26/hadyctt7RyZUdx5R8mE8CZivcM3DZrUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795876873;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=fM+ahEeqKs8FLRHjmBhR+K9wt/5y9sA9jAlfvq0QIDU=;
	b=DIQcjjJZxW0KZKtp74XG49M97oBSgk6PIaSS0otSJM1otE7cKUy8HjgaOHhKNfbcmOGq
	 PZqjdDxgtVpG/TYT8gup0GwKwTAWwbHUO39TKRwVBK+tpLVGfvy4WJrwhwiHJv4hMIg+4
	 XaiAGMUtQ/3QHc5A5AsGMwO6nbWqeHq1pJfvp41oAO8Ut8kzdbah455LBnc9KnO5zPwIY
	 ZCxUB1uxI0TReM7KBXkd7TZrSmenP2fsb9S7TAAgN8MaVhgfitW/NU+dkRGONnvHFNExU
	 r6VICJDtp+cMYp6KgFOhd/YfjZlGkrMbOGUoml1T33qv6uoxgPRjTwm3TmIMqXFK+Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Z6ADb/Ba";
	arc=none smtp.remote-ip=95.215.58.3
Received: from mta1.migadu.com (out-3.mta1.migadu.com [95.215.58.3])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036EB606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 14:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 036EB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Z6ADb/Ba
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=KIOYNIemMNQZRAQWh54GvWsLqrBhOpqFgcy6WYprPTQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795876868; v=1; x=1796481668;
 b=Z6ADb/BaxO4ftZSvXfy0vJ3bquX7q+FSbGQiaztwUn9WJ/51kdAXP3kXT1CSSsjRdD2Mem9S
 2AaNfTmhVK7wZ/gMVTDxEdq0Upqi/pXHA9nDq0wY4pwVabOtkYUf28rnsxolTCad6m7mPT3ThJJ
 HaBtglpEMFMCnezyfyqMEppk=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id eff9e04e158dbf52;
	Sat, 28 Nov 2026 14:41:08 +0000
X-Mizu-Trace-ID: eff9e04e158dbf52
X-Migadu-Flow: FLOW_OUT
Message-ID: <072b879e-0d39-4ec2-84bc-a2f2bcbc63c9@linux.dev>
Date: Sat, 28 Nov 2026 22:41:04 +0800
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
Subject: Re: [PATCH v2 19/27] Docs/ABI/damon: update for REPORT_MADE probe
 filter
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-20-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-20-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/24 23:36, SJ Park wrote:
> Update DAMON ABI document for the newly added REPORT_MADE type probe
> filter support.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze

