Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795747199;
	b=0umcvyJd/UU7Py7BOn696HVfmozSI5KSdnaQROboQuItyslo0PWwdnvJyjLunyRr9Vhn
	 O+4s+FP1HWpWhMNwFELoGJ3obhZutsuwDj0j7JC3y0s1Ffl6C4xF1WqdiI3696akP2FMD
	 5WGMw86wmQ9OCOdy8jxioEVshzHU2vV9zp4dkiNpMxQNWbh8He8/1276eBErMBIxOBozJ
	 IY1Gg1LYMGRO7b+cM2W9+8IESh7CHKETHeAVzvi7khzp4FVPcBgNWrOedPa7AdgeXojck
	 B6fboD9Skmx1+dmNK0zqPsH7Udm3iLkYbwK+jyrXCobL5jGS0S7/TEp9VblUuyuWZ/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795747199;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bsNI4Fukd37GtbVgvbYgtrSl9ji0CbnwHNz5uiG/joc=;
	b=eZhu+9wPbUYBwIXlzPFB2Mly9XGSSBMythgK5+Jeh0/amSRsdIrf7C6CqcIfezl8DsH0
	 btiT4LDupPAL/1AS8WpK9c28yoEWzL0aQ5iOW4c+4cN/FUeOO/3A+xnb+drQFxvBzUBST
	 AhEIAWmrf9Q2qrLlWos2DmmNaiSqIuJNwu3lOahMyBiGUNKp9ZykMaO5Mpy4I9Ywjhl3F
	 WegmXkWsQS39uR+MZmY3oI6n2YOnguVKT9zMTsWCvnq4ECfewqf7P6NZITS+EzmeQchMG
	 yB7wL/xbTcOLdCC8568HRziylDscqztjRYHkVUxxMvwFfNdjGM/HiTANPbvLudA/+jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PrZ0fgys;
	arc=none smtp.remote-ip=95.215.58.37
Received: from mta1.migadu.com (out-37.mta1.migadu.com [95.215.58.37])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD85606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 02:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BD85606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PrZ0fgys
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=TxihfaPAvNj2FoJou+qWNwzbBmmnVRhOZntcNwYjNNM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795747196; v=1; x=1796351996;
 b=PrZ0fgys4yaE0E+vS8yA8a1stTPQr8LOaKK7fK9PGWAOzGW/tmtXBy/EwaMB1WEqVrF7bse2
 Iqwp+HPAi1V5IunSUIvdZPOHkcFA3+DA9EYDlMnhQtx5cRHcaToYZP8gKqwBs+Z9BCwS/XjXDDG
 TBmBm2VKVAzjpMR1hvscV++o=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 08b58659fc6e016c;
	Fri, 27 Nov 2026 02:39:56 +0000
X-Mizu-Trace-ID: 08b58659fc6e016c
X-Migadu-Flow: FLOW_OUT
Message-ID: <25499f99-52c0-45b3-9198-53c3bd752c53@linux.dev>
Date: Fri, 27 Nov 2026 10:39:50 +0800
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
Subject: Re: [PATCH v2 08/27] mm/damon/sysfs: implement report producer type
 and state files
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-9-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-9-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 23:36, SJ Park wrote:
> Implement report_type and producer_state files under the report producer
> directory.  The type file receives the type of the reports that the
> producer will generate and submit to DAMON.  The producer_state file
> enables and disables the producer.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

LGTM, thank you.

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
