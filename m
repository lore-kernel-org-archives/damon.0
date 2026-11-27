Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.68
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767150;
	b=r3wtX9Bdq9KrroTH2ICRutjz97f+sGJd1CsUQynzK6s/FUsTntoSnu5ruGO3FDiN5wHp
	 cREl1gvTYriFsRySAHNYyEoB78nTRIQmxuDy6afZbY4SCb+McllhCHvZpNnWw/8MY64Gw
	 tHbcpmm3liuZN4UiqifH9SoYZgJ1l2E68vmwbyfF+PplF1UMSXDRu8yFYaaVlxNb73vQj
	 ZgFp8mxztW9Trb/UuWKKnlHUvC/NHpAYFHE/4MORRDbgmjr4bTG8WHurr2VcfAddFsICc
	 IMbWCpCnZPSJ6Q2EsSFo0H8lE4xrMS5zeTyI14LukhraRFIOJ7UNW4RvJrzeyjvBmaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767150;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=uKKPNPLKpRqOdHZX9CBl2LnHoQAUNh2byiuZ6R/mwr0=;
	b=Mfr8TY4/yjZKxdpToL79uwtqejHwwHM+oYMjBLNpssN/DOc4Hc8lWjSZ6F4B1P5knmmP
	 bKOS8nPUANw0+VmqgzybcfNPQDImg65x5xzJ8gdsxLQBcRGcCbLpfcPTgeuU4cfU6B7uR
	 pZfUT1OJ20DcaRp5qoOIlvAGOU9vO00OgIXbUpxbpC7nuV9t3RcGyhvt1L7y0iclcwEVZ
	 61N7JM9MItXJBUwnC7dfwU9a7klUavNUWEtQNORnvu7IU6svpT/DDJqdbMHyMfSDn8dZh
	 WzNXV/x8Ae4bIBr5E0CMsOjs8FNQq2qgYRmbRYJRd+7KSPs0qfiXb735q8kPR/yyQeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KrFsNWtn;
	arc=none smtp.remote-ip=95.215.58.68
Received: from mta1.migadu.com (out-68.mta1.migadu.com [95.215.58.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33825606A327
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 08:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33825606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KrFsNWtn
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=bTo0HVCZsJtjo3Aj6QH51oiIvjtPLz4cTFfCiO2IgAc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795767147; v=1; x=1796371947;
 b=KrFsNWtnvbe8g/TlPxajZs7/LLx1UDaX0Mn0hlEw00IDTp8UmUOuydCfX8gpP3UBRcg97lUH
 OreHB+Allxc1cmphz8i6LGqzoK8xSHY+ATIdalmfLQuq+tSN4jjgmvOH0kppIU8sXOjPWbSRxRI
 bAueUvlKxq5Uhk+7eA9eXB08=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id a467588598b3f257;
	Fri, 27 Nov 2026 08:12:27 +0000
X-Mizu-Trace-ID: a467588598b3f257
X-Migadu-Flow: FLOW_OUT
Message-ID: <dc1c8f12-76c9-4866-9217-a2a1b5d25a9e@linux.dev>
Date: Fri, 27 Nov 2026 16:12:23 +0800
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
Subject: Re: [PATCH v2 13/27] mm/damon/core: introduce damon_report_exist()
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-14-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-14-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 23:36, SJ Park wrote:
> Implement and expose a new DAMON API function for searching data
> attribute reports from the report queue.  The purpose is to let
> operation sets use it for supporting the REPORT_MADE type probe filters.
> 
> The caller can specify the type, associated memory address range, and
> the creation time range of reports to search.
> 
> The function uses CAS-based try-locking for the mutual-exclusive
> synchronization.  If any parallel access to the queue is detected, it
> forgives searching.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

LGTM, thank you.

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
