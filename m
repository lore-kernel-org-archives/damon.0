Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.96
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795880648;
	b=FUInNK5M1WN0jdV6hB7V2AEg2Q9Nk84Ms0sUHQValS5+UxjWY65mYRvt2kwwtwhhf+DU
	 YMmyee4Ua7LsERPkxhpZSGoNLCBY0OTf96Cwa8BWxSE42PhQXT8tzOthc5UtedJTvnGrx
	 eyuwnz6XsZVOHlJdky5pCYWCOj2covUTu0kgC4aB85OYaektYz7GPRNJKv5IDSKTIqrdL
	 qYioA+7QIw6+0s04njgZh5NKuoEBJI0RR0pBuSvAYeGHjpYC9cIJpyVU9RxxZqXzGRUFr
	 Ksgn4658Rc3HVo/it4zUen4DMJcZr8+arBbqQkrMdSenss8eqyvBM3YZjos2rQmGBrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795880648;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZR6I+uCGRcQT3VQP/n8Qi6FOu1zxOzGggkpwg44+RMU=;
	b=Y5sGVHL44nD8HFWNwtK3kDNQCIRmlOnog9d9uw/R8ynIOW55QeM6gnlQ92abL6qlbdw9
	 BDEpDccxic52yLsSKWuz0QoYyVYFfvJ6BOoATKH3hvrjxSUmi0It/9OCCFMn1HXjuBAPp
	 Gmlkki72fvo4S6mdA/nSu5WpsyNnhs5+h0EKjrQhCA5tOrLB1OagSSJiwUqIYfvaW95P/
	 0FFyNRG0Es+39pix7qDBEnZWd1ppV0C/nzj7PMVSHdAlXjwBeTlkFUmyulO16rDcJCPC6
	 3hK60/1NyHXY3iuHOSd1wRA19hCJSMGwlqdc2bAjzsnvZy6Bo8IKLIchDs7OjnYe1pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w3UxV989;
	arc=none smtp.remote-ip=91.218.175.96
Received: from mta0.migadu.com (out-96.mta0.migadu.com [91.218.175.96])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D28E606A321
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 15:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D28E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=w3UxV989
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=pQk3MK1YmTmi6DnhfbMUaQc8WxCiV16KAvJkYzlxz64=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795880645; v=1; x=1796485445;
 b=w3UxV989u08Hi1TqQe8xz2hFBAxKVo/PEWM+we6NDoByeshAYdPF8/whKdRVqmxZRodl+lsV
 Kj7r31AHwtOWEj3QKkODXuLYLmXeFP3tQxLhydAc8QeagyzXndo65eJebNxnD3HBPIGvoyzuLND
 PHjAcLZB9bXcjFPXw1AyD36c=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id cede9c7748931972;
	Sat, 28 Nov 2026 15:44:05 +0000
X-Mizu-Trace-ID: cede9c7748931972
X-Migadu-Flow: FLOW_OUT
Message-ID: <fd2dbc28-cd64-4e66-a6f8-63733786fd2f@linux.dev>
Date: Sat, 28 Nov 2026 23:44:02 +0800
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
Subject: Re: [PATCH v2 23/27] mm/damon/sysfs: implement submit command for
 report producer
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-24-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-24-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/24 23:36, SJ Park wrote:
> Let users manually submit a report of a data attribute for a given
> address range of memory.  Let producer_state receive "submit" input for
> that.  For the input, generate the report based on user inputs that are
> written to the appropriate sysfs files and submit to DAMON using the
> core API, damon_submit_report().
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
