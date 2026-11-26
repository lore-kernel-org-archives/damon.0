Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671390;
	b=hHKwopKQtswjKwppTAVjb5HltZgUfyLXfwzMxzp8qCP6qLf3ds2VRCgHxm+Lwd2SfVpL
	 yaNOKZ0ln+W2Nd2LZt7mmsRUYA1f0ED19jf8gPfgYt2rr0kCnetdYTSQa/nhUDYpvte/U
	 8BbaCcFG1aYeJ2E7bE5lBB2SpjfBySl+30otA3lOeZTCA4LGISfrr6NxIfEbBj8TMUQjz
	 +YeroCbb41lSWhVy7V6fc+9w3hxl88mAXLEK6nnfT4D8DsRBh25jL7Dm2LnnLWcoqqyZF
	 n1Q9MzA+s0tN6g/ENAjfNyVN/XS9CL6Qo+E6Y/fLNjDgrvXngfH1qTZnOnGaxLxO93Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671390;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=AodBlwpDiWRSi288fIhZCa0nGcYDVws6bZrTK/h3RpA=;
	b=kENRCciPna5UDwmH0EgmGhzQTK0+AUfCKv9S2hDc9jo3DxadxUfFcLEN21bP9vkW1qlu
	 n3mlcIeQZvZOX8CfI7rfK1n9wdO5rs3TUnugpWooDl98VlE+RbKtf6Thendwu7u4Qo4Th
	 /NFap37G7LF/vos3NlD4OHtUtUG9kqoHTDPWDo5/xCz0CzO/uTHZcknJz7W6AGRSrhbL7
	 vVc2diqbIe0iKbD9FK+4rem8WoY2ELDqWlG1bBNiS1fkfygoHUF7sqePjDMZVIiS/Uowi
	 PMGYTupJ+rIcToP1wShwp/F/epNfH37cp+AAVcys9wpf5oVZ9chasndoxfYmorA+/Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vX743oeP;
	arc=none smtp.remote-ip=91.218.175.61
Received: from mta0.migadu.com (out-61.mta0.migadu.com [91.218.175.61])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C734606A31C
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 05:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C734606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vX743oeP
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=kp2zkzyDc865q46+d1AEFq6uaEh8U+dzJCBvqx8kpkY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795671385; v=1; x=1796276185;
 b=vX743oePNPEydQplnwINqOUy5lJqMh01VM2ZPDFF2SVsUMxnocCj7Cf9I1dW7qS5HdacfeaM
 Gw9JqE+mroOrbHa+lFQPeOukysVsirZVAoezam1R+ZJO/6aswokPexi7yPNqwbHTJWrQCZk1cVn
 K3r0O40RdJIXlc3zhsskHt/I=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 69ea2c5db0ff0af8;
	Thu, 26 Nov 2026 05:36:25 +0000
X-Mizu-Trace-ID: 69ea2c5db0ff0af8
X-Migadu-Flow: FLOW_OUT
Message-ID: <18dd1ee6-21a6-40ab-968b-33042a2e11d8@linux.dev>
Date: Thu, 26 Nov 2026 13:36:21 +0800
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
Subject: Re: [PATCH v2 03/27] mm/damon/core: introduce damon_submit_report()
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-4-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-4-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 23:36, SJ Park wrote:
> Implement and expose a new DAMON API function for submitting a data
> attribute report.  Any kernel component in any context including NMI
> context can use it to report their finding of data attribute information
> for a given memory.
> 
> The function copies the content of the report into the DAMON-internal
> report queue.  The copy is done in a ring buffer-like manner, without
> being blocked for consumption.  As a result, the queue keeps the latest
> reports up to its capacity.
> 
> Use simple CAS-based try-locking.  If any parallel submission is
> detected, simply forgive the submission.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
