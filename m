Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523511;
	b=PCSlo3O5AfpNLKcWqpqNXxan4Aqsaa7ClD+Yh8VxVk5TscYi4EG0Jr89zE+6ibCgPp7k
	 iATfZcXmYmLyqAmSNZiK6ocFEchRsf7ZrdVA0aOczgO04TNVOE/s1stijmhtSUvmBzN8S
	 e44SccI+Da9kAaFW0q4xKLmw9crEPCPGztiP04HdIE3aH1ie2GErJZqsh+jjfzhgxb2YI
	 bDFS9tPAjKc/nTp6xMTRl03BX1+4fsdLtAqj4YOFSCKrS85XypxgDc94lG0XUawCo+Ybq
	 1eRY6O9KuRE+TksyzZiuaB8Ignh6NvjrTl5U8c2Y2X8ZhZmf1pjs3ioWTUSdDscpdjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523511;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=mzeVhfSZ86GczgIIPjVQ8nQzZ5ybTIQyIIVFuNTUIeQ=;
	b=1vdt86c3DzhYwVK39W0UGDxYzrSlBCJCPCCkDZe8IJd57CFuCmIV2PiGoCns1kzcb2W9
	 kbmMyagFlF6zRHyVt2kc/sRhaasoylHFdp8SFc/okdc4O5Vkon1vqbCAQWxh9N1EZLNSQ
	 qVGgJwBaydANGdBinLNXcrlEA03HC7H4j5xfn/F3br8+LwYpZxtxu4RUZl6x/sAJ7hBFj
	 F0M3Bb2g+KRtkorPU3/7c+aZQPbN0yGEy2p1S0JnjVx20l5iAJnz6q9uGoh/siL2IPxXx
	 HWvCYn2mcT4/zphG10xhsdVYwVhxgi+iJVIvLKulwRDSbUbmgv5755+RphOSnouZ5rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jOSwe+A2;
	arc=none smtp.remote-ip=91.218.175.225
Received: from mta0.migadu.com (out-225.mta0.migadu.com [91.218.175.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C33606A321
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 12:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9C33606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jOSwe+A2
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=60Mk88KLHnZn4rnhSt3irzUfk0fS6Z9KyiAAA3YzneQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795523508; v=1; x=1796128308;
 b=jOSwe+A2fJtrV60g11m+sBsQY+nlI6PuDS2QaENd6YrYDSPJwTS/rSFt+pnXPA63aPFnSokM
 WBVA0ndjSpjS9nfGVXkqGc1pW1muTznHe0Grsm7fLiwT18uPzmPz4IhghBfXJc4DV0AMypNnoFI
 7QTVDiN8yMWvH/G9SAjVn5wE=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 9dcfa32912031417;
	Tue, 24 Nov 2026 12:31:48 +0000
X-Mizu-Trace-ID: 9dcfa32912031417
X-Migadu-Flow: FLOW_OUT
Message-ID: <835e8def-f4cf-4422-849f-08ad42f47c8b@linux.dev>
Date: Tue, 24 Nov 2026 20:31:46 +0800
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
Subject: Re: [PATCH] mm/damon/sysfs: skip registration if DAMON core init
 fails
To: SJ Park <sj@kernel.org>, Aveline Noir <jm5905938@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lian Wang
 <lianux.mm@gmail.com>, Dawei Li <set_pte_at@outlook.com>,
 damon@lists.linux.dev, linux-mm@kvack.org
References: <20261123153601.85440-1-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261123153601.85440-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi SJ,

One tiny thing in the commit message you proposed, pls see below,

On 11/23/26 23:36, SJ Park wrote:
> On Mon, 23 Nov 2026 18:51:45 +1100 Aveline Noir <jm5905938@gmail.com> wrote:
> 
> '''
> DAMON sysfs registers ints interface even if DAMON core initialization fails.

It seems to me that "ints" should be "its".  Other than that, everything 
else in the message reads good to me.
Best regards,
Enze
