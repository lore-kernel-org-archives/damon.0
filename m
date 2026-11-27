Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795747915;
	b=sXsx5Up5Z3GxHO5lHayhPK0dZ2QLG2LSENLcnXGmu5OXEhOgtuToXAlOnZcwH2+T9vC/
	 lLAV2Ua2HyNsepTrvjgt+S1PoODobIdlY4v7uh3UacDqeUclyaIMXyBgH+CrPTYc1/ycN
	 fH3ClIeILKgWCMwBA5/JsOxRAYJvDT2uicUd41/LUlfAoz0ppEVORQ8c58o7ScBpUkMZV
	 cmyKqGJgYRuIjJlwCF8pGC+qCIXyptQfB7nMHwp1qenL3SznXCHvCM5EpLv2lhxBPfk2n
	 FToW94ZShOEV3ZDLhR9zcX6BVA3Ts9j2nz/oHIVuzB2yMcvbX4/aEiLsAuuYcoWAIag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795747915;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=U3GFXWam4TmIQpT0XlDq+Sl01DF1V8kTIQ3JQPb/fqk=;
	b=buj56jWotsFeRTVjyxDUjbpFeT4g58sgLlHow4Kdsi8+xm7rLWy1s0lcderU2FwPRcSO
	 XGJ2/hxCcAPXwRg76X2o/9nuTaJV2lJJXbyYqRzEDMm+aO18K4tKF9Muip7IchKjCf6FI
	 ANVpH68x2eFCj7EaWLzvJaQop4vK+lw0ZNspZBuQ9vqpyvgcQUuc94+tddyDslMPLTbvp
	 OoBUe9YQIjMnGSdKJIzFqMYSwUNTyccZNJTqoBTV4EDLKfByaXnfDc4pO3mLTE2E0bbD6
	 PqKGo2YRZtZHNB2wJMQtu/9GY3cCw8v745/H+DII4a/F+p3TkHr6uetQy9oTn0p+j9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gDlFrTOj;
	arc=none smtp.remote-ip=91.218.175.101
Received: from mta0.migadu.com (out-101.mta0.migadu.com [91.218.175.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8021606A31C
	for <damon@lists.linux.dev>; Fri, 27 Nov 2026 02:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8021606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gDlFrTOj
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=n/yaE/5u3zb3VjPb/KsOiyC4y5M5RXSQDqpebthex+s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795747911; v=1; x=1796352711;
 b=gDlFrTOjSgBaGde5t6VzQd1WSF71FYfQITuNJh80zcuQVhmY0BUa1uzonkW7yOs7jj/hoCRR
 RMvNWXHEHthv8/N30p0l8fUZ+uHBxTiMMHKXnAnMnlVuTrwYwCQlGMsyYhz1PZBl3q01daFTk/v
 Nh3kSwvGjWLc1LVwahZzUBYc=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id f83eb12f5863e0f1;
	Fri, 27 Nov 2026 02:51:51 +0000
X-Mizu-Trace-ID: f83eb12f5863e0f1
X-Migadu-Flow: FLOW_OUT
Message-ID: <bdb0ea5a-97f3-4a46-a541-ef01c062d6c5@linux.dev>
Date: Fri, 27 Nov 2026 10:51:48 +0800
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
Subject: Re: [PATCH v2 09/27] Docs/mm/damon/design: update for report system
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>, damon@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-10-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-10-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 23:36, SJ Park wrote:
> Update DAMON design for the data attribute report system.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
