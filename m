Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815150;
	b=w2cJ4UDVXp4+km7QUDiFGlz+2aAnez0gA6iMBs87ECC3505KNvU+uL1f9i9l4KIVS7tT
	 yNXadk07P/IIAiM9E+QvdOlYYkG3kPL17qHz5Ps5PF7y+9UkZl6pm9H57O9iYnrySKsCL
	 XUVosAeKpkupc5BSoN08ldvJLdyhzspxp0pNilAdFJ2TH34kSMh9AtvlXa2sCGiPAl1wb
	 6AHSF4yCXzikz9wyBeTg3xrfp4SQk1jZZw53C6HQooz3tR5L1b22pgMBLNWbM4562KJrv
	 GWoyJm9kdMLVSGoPYE4Iy+xKIb4sUz/XLDENYnaKEo9UUNc/o+GNTHmInTOUrxeIrfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=zmgK2rZQB0Zps7NPdGicEsUeC+FDAzmra5NHyyX5KYA=;
	b=ettabXMlJDg1o1qfADx8xI3ycCJwHx/yYC+LMsJoZKgfFFtKtBwPyUaGknldeX383c8J
	 y9xIlu+2+86qTsLZglQ1lORqsCiXW4SoYIIn2W9ktZu3O2tLxjnd6ILNlIXuAaIFmuEdP
	 blMh/kMPMywD4a7r/+OPeQ8F7Ntl0EwU2tIEMFqmm0EXWAlZnAVaLPhL3EcCOp7FOYDdy
	 dqN785tXTIvK3BN5a9d2auoUoOo8A5FmNiHdIOD8a+wGYCOhxQJ5rKFARRwd3kjvFa4xk
	 VLyGr5bdn+vppGzyrHSgij6QDFVjZM2aDbOs6PeHnpq/a/hgZ8OQY+SRh7vR/bW3lCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QvY090fS;
	arc=none smtp.remote-ip=74.125.227.202
Received: from mail-pi2-f10.google.com (mail-pi2-f10.google.com [74.125.227.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629AE606A8A5
	for <damon@lists.linux.dev>; Mon, 16 Nov 2026 07:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 629AE606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QvY090fS
Received: by mail-pi2-f10.google.com with SMTP id 41be03b00d2f7-cd6b195dd0cso740257a12.1
        for <damon@lists.linux.dev>; Sun, 15 Nov 2026 23:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794815150; x=1795419950; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zmgK2rZQB0Zps7NPdGicEsUeC+FDAzmra5NHyyX5KYA=;
        b=QvY090fS04hH8XGK2B6JeDUcR4xA6JvL+haBA0olJViI7wAzkYycHlEMjIZ9aupEey
         LnfwPaFVhMevAVJaFVKqJAX2PY7jeFkAqxNFM97ncn43/jp3823n995SR6n0Azfe3lry
         w9LjTbO0pzaU22TSahXrTix7LjKQH3kyzDuitSPltDcXSLJpFXkSG4Ec75qyHcXtRkkm
         OAv5CiY/rsIwnvbl4maO1MQBw2rY5nXYaUSnzh27ZyXYcgGqHpSgCnztr4bMHZPY58tE
         a1A9Q0APf40Pjs6GADVVRFL7Qx0N2z/XcXz77GxBAFu7yT5QNOauAqrh853pxR5aC0sl
         FRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815150; x=1795419950;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmgK2rZQB0Zps7NPdGicEsUeC+FDAzmra5NHyyX5KYA=;
        b=xii/dt9yBmUKPiY5xIbzZu+NJgrb+jn9tHohhsZCOWiZtSJtZ61RClMFru9euxEfM4
         JjHCrbc4LBNWJ6cjy6Qr7q0II0s/cDDhp6dZloZz+O5leRytSAXQgdexVZQkRqiSJJdQ
         6U1xKwesq5UjDY8aPXFxDFmvO5RL36V99WXMrrnuWohA2GapYWi/yZ21t2Vsha7GPKsj
         RwoWPMkHXYI7ddBRMcWZunzN2mdXqiyvPmmAYiUnyFqMP6qmZmQOCiJNjOqeZPL5+4NP
         UFo0rMKYLEvVmmLlhoS5xrbzy9gfGB0qYOzI8sNgPsFhLV2NugF56ynkwWU5uZ8h7G0i
         unfw==
X-Forwarded-Encrypted: i=1; AL+hErGXHkS6bTNYVRIbo44Lyn/rIRWQXy7YuH5GENDl3+flbOEDcVUZKHhBbO61LaiHxECIl+h53w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/DmfNyY530YCLUWTyVN4a9Awt4gyGI5hKBblGcJPAU3WyoM2xO
	z5Qlq2XbhqmT6hfV+ajpnIssv3Gs9k9BdbqQkts4HONUd20HP7FVRxYM
X-Gm-Gg: AYBFou1MetylACOvyXY9bM9h1pcCEXehk+J+OucnD8va6Lknesa5VbhUhjzpnfHB5+G
	0lJgrjDONkwpRvmxlQ2adIrbwNIFCqAwHcpbMsQmp1+WoLokUUuVpkj3LjGReD+J3nKsgk67ZwI
	I2vGcR7rsYWEmdvkM595cJmAr1u49QXZOOzITXEOMCuY2QSTOr6SQ7bkH7bmPR75ZIfJ2li4UBy
	5KJQ8+Rzpm62mCuiK5NGZM0kFCWbZS8gNvCA9rcRcBJ7dsOBfyIpVfBCoiKbQ5fLqNtQlhKSVNX
	1ySbVO3F0swfgkRD2hGE6ERcyUHBTLiFK5o7WeoNZLH5NY4M6GWnXwQHyjgiWFkeX/AZw8ZOW8+
	J2d9ZpIfvgE9+v5pwrmQejsqJ4wZF3417RUbjYYbAVPz5ajcMsIndLb8fqS2XVYqan9Yjr8smfS
	Q9es2LaqmRHd9VJytwIi2ros7XH7Gg6zQel5aF+SYo+edkE3GATp18d1aBc8naMFVvYcjWfPadn
	QE389ycJHayxIDzB2HRDVVel414skbUNVq1a6VYa8/aH900vcdC0t9+X355AGGuXbeGgb5C+z1P
	yfSt3nMhrq5rN1Bm/ucsp5jibALlPHVrTuePl3anHst4K1tLrYfVRUK0nNWPP28dXO4rPJ7iMqv
	k/yIec8y2jKTOOxVTor+kpKPW/APHBpQZcBU1bEOGvLbJB2fHRS7PLLR09TNCh8o=
X-Received: by 2002:a05:6a00:181b:b0:8a0:7677:c8c9 with SMTP id d2e1a72fcca58-8beb7c21179mr8733834b3a.51.1794815149534;
        Sun, 15 Nov 2026 23:45:49 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1a6dbd9sm3244287b3a.27.2026.11.15.23.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:45:48 -0800 (PST)
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH 14/27] mm/damon/paddr: support REPORT_MADE type
 probe filter
From: Aveline Noir <jm5905938@gmail.com>
Date: Mon, 16 Nov 2026 18:43:36 +1100
Message-Id: <179481501691.2405628.8067144236288202449.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, sashiko-bot@kernel.org, 
 sashiko-reviews@lists.linux.dev
In-Reply-To: <20261115202849.99134-15-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
 <20261115202849.99134-15-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sun, 15 Nov 2026 12:28:32 -0800 SJ Park wrote:

> +	case DAMON_FILTER_TYPE_REPORT_MADE:
> +		addr_range.start = pa;
> +		addr_range.end = pa + 1;
> +		matched = damon_report_exist(filter->report_type, &addr_range,
> +				jiffies -
> +				usecs_to_jiffies(ctx->attrs.sample_interval));

Since the window is counted in jiffies and rounded up, how many samples
see a given report depends on HZ.  With the default 5 ms sampling
interval, the window is 2 jiffies at HZ=250, i.e. 8 to 12 ms, so a
report is usually seen by two consecutive samples.  At HZ=1000 the
window is 5 jiffies, but kdamond_usleep() sleeps via
schedule_timeout_idle() there, and samples end up about 6 ms apart, so
a report made right after a sample can fall out of the window before
the next one.

With the queue indexing fixed, user reports submitted every 50 or
250 ms and covering the whole physical address range were counted
about 2.0 times each on an x86_64 guest at HZ=250, and about 0.84
times at HZ=1000.

Is this approximation intended?  If each report is meant to be counted
once, maybe we could keep a per-context report sequence cursor and
check only the reports enqueued since the previous probe run.  A quick
local hack of that counted each report once on both HZ values.  If
reports are rather meant to stay valid for a while, like a user saying
a range is hot, a validity period separate from the sampling interval
might fit better.

Thanks,
Aveline Noir
