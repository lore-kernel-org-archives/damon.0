Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795686970;
	b=S6dU6Q07Md+/ieiQCwyVvKZrCMQ+vsrqjNLO0wzUVBmFk0Qmgv2bRpLaawHFXXX0sUve
	 Ay3bKQ2Jido3Bn3VR1RZiIbHKAE9lxkvvtGstp0dyWFfaVo8wP6dfT+Q7p885H6s8qjDk
	 NQS1QzmB89aHx7RfUtNjRP5YRMi0TXEWAEzZvKlsQUzB51slaT3B9N7TVXmyLlDe8wLNv
	 qyOYq4ng0LOst+jtUX+CRE8Boku8R4nbk3h178kqh/t8TsaDtYZytYpk9XuOZhUHnOOrj
	 WhyB2033bPEkdukFWYpOSdbY1OnbOOfycQ5ZzRUWop5i5+yTVx1CpAVB8UH9SlI7cVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686970;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=BQcIcei88kUqCnw+OzaF/BPCcNprpGmpU6tq1V0AoeA=;
	b=V9ZSfrc67zdR+nmiSLanFgBOYnu6/tsT/6xiGPa7S8P9tBZsKz+s7Gi//jb09qjXZx/e
	 xdraTT9QX5NSZUZLVHpPc9lutFcAYuRuFcwp2l5/sSncsZOoz2vqMO6j984fTCPv6uTce
	 1UFGrCATZKPqPHMzxnmO0IDgIemkTGykjpPpOnAImT120gyo5bPfXEMc/37u/ID2uDYkk
	 5ON47CJ11qeB2l3iUiLzygAC+k66CxVMqDoHEslmcnv2La6/N7SVXru68GFE+PGQFvWZh
	 xivit8IHoygJul6QCWmGAwvUvmuLInk/LS5iDqvI98tvBWmHsPk3x1JWpEk9DbyKe2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F8wGvLSG;
	arc=none smtp.remote-ip=91.218.175.42
Received: from mta0.migadu.com (out-42.mta0.migadu.com [91.218.175.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20C2606A329
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 09:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D20C2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F8wGvLSG
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=dxPJpYyq7fmjNCgcazcTAlVEtnKcktGtMN2JR/cLLl0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795686967; v=1; x=1796291767;
 b=F8wGvLSGGHwwvClbV9xt7ors1OyBtyBOwm/iNTdtdHmTT2CixXnH5DbsLdPRDcSIcJZjLuH1
 +u0Cqp4PaaEBcLGqVaIXTWmJmTUajjIL9hzhav3KscOlwXkg9UuY3tD6xVWQFxCbBqhEVgk6lC8
 n/QJM2rprvnaWIVjvJusqC/4=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id f274d0239c21fc85;
	Thu, 26 Nov 2026 09:56:07 +0000
X-Mizu-Trace-ID: f274d0239c21fc85
X-Migadu-Flow: FLOW_OUT
Message-ID: <0ad1c783-8ddd-4f55-a08e-ec1e690f92d5@linux.dev>
Date: Thu, 26 Nov 2026 17:56:05 +0800
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
Subject: Re: [PATCH v2 07/27] mm/damon/sysfs: implement report producer
 directory
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-8-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-8-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/24/26 23:36, SJ Park wrote:
> Implement a sysfs directory for each report producer.  Create and remove
> the directories for reports/producers/nr_producers file writes.  It is a
> placeholder for sysfs files that will be used for controlling each
> report producer.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze
