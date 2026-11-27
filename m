Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795758415;
	b=oGq+V3Olahyma3BmFdnLx1uXYxtHXUqtqhn9br8/YxEBLrTPVSUPJY/VseFGHY8FaywC
	 8dvrc3TUh1M1/jBzCQZwVp8J6u+GeySNvX4aH7s14NlCmQ2LborHJn8Rq1qahAIihKH6o
	 Yo6DYpw2aFmRRbXBu2kEpqJp5HxVpXT2hXxVC/4LzdhZrs/zNEKfZtEfEKrpUMhNfEQWe
	 EFIzMnj5eiZXvMW0gkWylc4yrKIq4Ep9BN7qUhD2vgKqC/Jo9vOUcLBrhmZs1Fuh3hDKN
	 W4dX/QpYki5HulXyAw+H0wXvwYgL4sOeA7rwjWjF9Ty6sq6yOUtkM9ARLM7/Blso+lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795758415;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=dgr6yYu/bEkmWQcZMvll0LChD2e6ydySMbSI4Jx3qok=;
	b=j6dnAys7JjST+53/7Kxppgv/R4r0XAVjRV86J0wZwp4GwkDQMpCT2T+/1eeIaccW8bM3
	 Qe5RG6Qbib76Q7oPBrofXRTtZT+5uIHdHUliadSUtY4r66I2PL8H46P+qwjL0FRkHE49H
	 VtY9ZY2mXyrE3T43B/r2MvpiGv2zwPrnxxuygl314is+1b+Hw8VisZBzaEyCyUdtNi86G
	 mIYIGHEKOoMYcdlhm/rCuSy80gFK+8JdGVKhHjrFmzteTDnJsTb+b02u9X+aokPSjLtms
	 ZF6bHMflqe0cUCHzQ14xzlDY14UY0NSXc+cN/5kAVPyiipxbodq7ca6E60VpckQsBjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="Bg/S1xKe";
	arc=none smtp.remote-ip=95.215.58.172
Received: from mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80EC606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 05:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D80EC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Bg/S1xKe
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=7vNbjUCz8mvZXTBuqZ+Jkr5tNyMEIFqA+f11SfeE4zk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795758412; v=1; x=1796363212;
 b=Bg/S1xKe1jMvgVhVbYFum6hCqVhy8Y6y0KxHCJNRmb1qlpwtu7xGUWxX+kQ5hhpkQatcMXVA
 u2LG4uUMPjk6CkJZLee69AS3GuwroL0ze32UAWvF7OhMhOlBw8m6BFFN6HfziBsxjEuXbUY8emS
 74dahaxFVzZp0hkOutl7tSXI=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id b8fa1ace7f61a211;
	Fri, 27 Nov 2026 05:46:51 +0000
X-Mizu-Trace-ID: b8fa1ace7f61a211
X-Migadu-Flow: FLOW_OUT
Message-ID: <0f466933-27d6-4d2d-99db-8cdb3cf2c78c@linux.dev>
Date: Fri, 27 Nov 2026 13:46:25 +0800
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
Subject: Re: [PATCH v2 12/27] mm/damon/core: introduce
 DAMON_FILTER_TYPE_REPORT_MADE
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-13-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-13-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 23:36, SJ Park wrote:
> Extend DAMON probe filter for the existence of data attribute reports
> for the probing memory.  Define a new filter type, REPORT_MADE, for the
> purpose.  Add a union argument for specifying the type of the reports
> for the filter.  Update the new argument for the new type when new
> filter parameters of the type are committed.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
