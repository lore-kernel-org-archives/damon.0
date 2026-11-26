Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679722;
	b=dsh+5JaEEp+FOb7WuDmL7xQiiKSxtVz9UAjT/qtDvaQdCjxg+F5L+SHZPJw2+xrn0BXY
	 aL22+ST7QTlHya0n2NNtz5IgqyjDmpMaROWbn+D+muOfe/621pXHB/fc+ELdGaHbiOpod
	 25PJN5rQSzM7pWV4MOM9P7jPwcxjsWoycQ3C0vyifMuOMUKH7ExpiAcm/zh54FzvDOQNs
	 S/0I75IKFoMjMPOEUFXPzR481SjALxzV7eWf6jZp0fJd2sclYPtwvi9f0ipRiKIZfZ3+y
	 jMH7ESyj7QyoYnu5o93q/LdDfj71KRl2NDuKx8rj20AUpTC526IpFime7XY9O14wwwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679722;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=/KxexsUFrdq+SvWf58I1oOaEfLJEYq/Mus0bFEPpJdI=;
	b=QnhqTzhOMO9y8p86nADrA33EEbCngU89bZCtl/XM+DLGvATya8K6FdtRC2cPhO+xiqgX
	 6keWsrNerAhVzqdDoTQj41ZlQgUTrs313IpK9CsaGzkYbvG4v95mphYy2HgpANZmINI1k
	 gNuv+lAF5E6vnLeM5WiwRLo1Vlu9MWLBwZ1wam7nOGw9cQXuCIwsk4q4ghxLgeTC/QTNm
	 D55JNuAxzOZ1tiH52PQusm2tHIGEN4PQ9c25JKM9bZHbtPNGjmKXQBSvTHDoPHGLu1aoV
	 HhnieXmrFNZdOOAP2six5iU87NMXHlBaBZF5lXK/zFQHbItSM7D5lCm6l2Rw/byvAYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sj+Lixzm;
	arc=none smtp.remote-ip=95.215.58.107
Received: from mta1.migadu.com (out-107.mta1.migadu.com [95.215.58.107])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD43606A31E
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 07:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FD43606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sj+Lixzm
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=3j1o9AnXc+X/hXLOjeUWi2Tk02Miri7HG4XgM6cikwo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795679719; v=1; x=1796284519;
 b=Sj+LixzmgmHi8dK3aDxze1WZQWbYsRxGLHjWlizdR3gO2a2N0cTaXYcHSiSmZYmznskx5dWY
 gu5/HWnDGnY9r8ast164GGp+J9Sm0ss60VImkJ9Zzik7JZL6s0ebVLvtDiUqSR91tloqDDaCxQZ
 f+Wa84N2I4cxYhaw0AaRfeYo=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 6706dab2cba26826;
	Thu, 26 Nov 2026 07:55:18 +0000
X-Mizu-Trace-ID: 6706dab2cba26826
X-Migadu-Flow: FLOW_OUT
Message-ID: <655c1708-94ff-43bd-8998-6448139cfc16@linux.dev>
Date: Thu, 26 Nov 2026 15:55:15 +0800
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
Subject: Re: [PATCH v2 05/27] mm/damon/sysfs: add reports/producers/ directory
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-6-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-6-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 23:36, SJ Park wrote:
> Add a new sysfs directory, producers/, under reports/ directory.  It is
> a placeholder for files that will be used for controlling DAMON report
> producers.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
