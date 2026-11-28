Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795880106;
	b=OlWHiye9bZ8ckzZAcxWQhtQoeYUKtMchHOg3OYE7dkr0wu4r4sI8SE6YLfJKfBPobrc+
	 IvgDDMq/jlPeEFxVC3T6Duk4SsDQgydOGa/12WoiVZppfoS7uC3v/a16Xgzx4C6FanFqf
	 qblJanUg1aoNPRGHrT9aY+6ihgo1QrzhBfFcJQgk618u13xwDUDUca/Z91T2SNxd/xxIw
	 Wg1enrhcdyckWn55RrMBHGHUAfyVMb72flQP4kcxjdr2ejFQILVEz/YKJPGT8amX9HOjZ
	 ILVGYeGMWM1HxwAuN2AJzBt3lIw8qmBtemUbDumBQYPezfhfQ5Fd0eyOwqMjuamQpqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795880106;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=GwsuOvjgHntc24/+jtBIIyAjxkIXD3xqbEf4SdNzPy4=;
	b=o4VmC0cWgsHT5SteP2cEYz+AvctAHdPzPsLeQhrHHpnG89yuVfqIkUAgQsZBs4kGUPXI
	 EiH9qyD2hkmfoTt8J0hQndbNI0OhDUs1MdKkkfk1IeBIzlMBYVo2JSL6yvB2Nhv5M6DNy
	 x0J1E3uN45h1SIK3VY+Or0qngl35e5l+L3JhcNXAR1W2+LP+aiqahCCa1IqmI82ThfF2q
	 68Xhi5wWh7xqdmmIgOan2254LnlEApHqRVjq/f8J22LHnfFz8c8gJLmoO6s8mE+Zhtx1/
	 gSBpdOtoHwXfxUJB6EL+hmats0tel5MRzKSyN616UssPX4nz6myC3NxZmj5y6kc9c+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ryK9i8uy;
	arc=none smtp.remote-ip=91.218.175.38
Received: from mta0.migadu.com (out-38.mta0.migadu.com [91.218.175.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA858606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 15:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA858606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ryK9i8uy
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=JE5aFl5Ux22r+Ify2mYQEna85pPVFAuOlbMUhQoJWTI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795880103; v=1; x=1796484903;
 b=ryK9i8uyAFVaUpCqU3MvBMjazE/a6uyokho0bLLhqSpOUODsyYP/ge3aYq8FudpMNhHcwPDr
 jFqOZKcA4w9KmpzbP4Y7iZA3eG11u2ExlbtfPIJWvFSFouX5J+LPZMvww/js2EpKX6PmB6BUPIR
 wX07r9zmrLPtK/jvdD/AGSck=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id b8536257af4a8a07;
	Sat, 28 Nov 2026 15:35:03 +0000
X-Mizu-Trace-ID: b8536257af4a8a07
X-Migadu-Flow: FLOW_OUT
Message-ID: <5ce65f9d-7125-4e05-bd77-a47de4ce1732@linux.dev>
Date: Sat, 28 Nov 2026 23:34:59 +0800
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
Subject: Re: [PATCH v2 22/27] mm/damon/sysfs: implement report producer
 addr_{start,end} files
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-23-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-23-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/24 23:36, SJ Park wrote:
> Implement addr_start and addr_end sysfs files under report producer
> directory.  Those set and get the address range of the user_report type
> data attribute reports.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>
LGTM, thank you!

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
