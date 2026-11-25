Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601193;
	b=HZeuFuSHgPDoMMR9UkYmbiVFHZ7MiwKDd14pswAZDnup8xu5daXW6tkiuHGQEiVpyy+d
	 Ma3pod9lEHQ5eWPDleO91V2aMZRIYy2QfsdL84hIjJW15uk3TDl8zNBCFPwU+m0fxqR5Z
	 m4DkIAy/oh4DNYsYydVx/pKHBTLOHAin4u+mi6XlmuS4584i+Aj6qlXbzQp0ngUgaU2VB
	 CVvS4oepRUb8fD0JFZ/xHln6B72zz2IzZ6HC2UtYUpcMFVhlxt9NPSpIE7Z4AKNEvq/54
	 Lj+YsOgbPyzNIHWBp99ESHtq6vDIWyTzht7DtHm009Cd2H4t4/UivkpL4vgnA9ECCYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601193;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Arx3BJNS+dbXZzp4h/tce0DGEBdUqyAuZtL9wSo0Tdw=;
	b=O7IFQ/9KKRUY58n79y9B8/6Wtl3ae1WnxCCvNFruMRM+843HojSBOaRhw+WYw+u6xHx+
	 TCKW+3tdhf66h1RIH8oTAvajZ1pjmHiFoo/PSlQxgRDO7ptxhpcosNPUjtlneQX7j5NEj
	 Xxjo2G36menphHlH7vExHGfHCsaov05dzTwNm/zCAVLRS1fgOuFNv6MrBlsCEjdzkdlPX
	 +B+KSvS+OGH+IUOCXeJfl4QFuUNe/K2D/SHMicUk0pA/7dmtMZhnQzqAdbSCS0hiVp6PZ
	 4Slm2joKk5sFoWYebpqSHN8eE8NkKj19a0EfJd77tu3GxBNhW5Hse+BB2NRrg1wCdmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rqcluRyp;
	arc=none smtp.remote-ip=91.218.175.180
Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16A606A31E
	for <damon@lists.linux.dev>; Wed, 25 Nov 2026 10:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC16A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=rqcluRyp
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=PsZOw7bb0SZdIWP30vhMxqaF4WJhPkOQJioKFLKp5zU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795601190; v=1; x=1796205990;
 b=rqcluRypAtOkPq8Eh2yvStZDZFUGNDNb6iZcpxVjGuSVpiwAja6utt8HZmkoJQ3tN4BzwRrD
 dRb2Oim7V5lHkRsQcjFSOeMh6afyuzoerFEPzw/Fr8VlfGsHZI9ryn8aSUh1HlcOS8YHNoOx/xP
 O+Sm3+onzhyBTawWGd9hr2Sk=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 74f8e64801debf3e;
	Wed, 25 Nov 2026 10:06:30 +0000
X-Mizu-Trace-ID: 74f8e64801debf3e
X-Migadu-Flow: FLOW_OUT
Message-ID: <17263a6c-b812-4a03-b64a-338224142e35@linux.dev>
Date: Wed, 25 Nov 2026 18:06:27 +0800
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
Subject: Re: [PATCH v2 01/27] mm/damon/api: introduce struct damon_report
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-2-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-2-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 23:36, SJ Park wrote:
> Define a struct for data attribute report.  The struct provides public
> fields for the type and the memory address range.  The type field
> represents the type of the report itself.  The address range is for the
> memory of the reporting data.  Data attribute producers can format their
> report using those fields.
> 
> It also has a private field representing when the report is submitted.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

LGTM, thank you.

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
