Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795876227;
	b=hri5esJO3DXV2phCcya9XCrE559APysl89rRKhjpZ5/+NKRHzVZCY9nXnkJR/DV6ZDsF
	 oKDceoNWzZSGE03no8KWLIhVy/9ZjUTRWAj9v1WLZL6Ab2EeU7WMaBcMF+EcCBiIkngnF
	 l8Si72oowbNLrfBUySkoLP8q7Vb37TkCuSVEnEgJvlhh1raAvTbblVrL1RVhmWWf6s22M
	 K9ZAIa74q5qszZ18cWe6aujPNdcYmgipicgzi8g60kcqcyDHaur633dzMFWXg/gJNCaKN
	 XcgB567K4BpJagMBS7OVOzYf521bYOu3S1V19uslPuqI6ztLIIrQVG40EO5tr3FYaxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795876227;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=vq4q9cwRtuK53vw3iKxhgmryKRcqIdb6rrnEW5KeXZo=;
	b=FyR1oVmOnrtWApMHsKcGqFSuUspEp0ZbcKik4LbkB4r9INS3DyRjpGzx/qwyTM0clvd6
	 Rf12mwc9r2xqLqspJZirdl0FsAVfrfRZpcAyY2+X9fnyb9+kz3utY5wMVca+Vkx+Gk4pt
	 c2hJbvjAJ1PBlZHZbUi8BYTxh7e9x/UxbpP7dZlv5InR9e4FwTd77MghtqEFAw1DCqx0x
	 Lri4hsSFDCpyRFFSoPJPADGze6yDT15MCWlW6cwG14QCn3KC1cD+ocpZuqbokdsBahz/j
	 uy3IwsWwsWPqLEU4I0sej5pJVaBx3ZzBg4BMspec72dohno8zOHi95muiXp/R4KPGKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HaEbLixJ;
	arc=none smtp.remote-ip=91.218.175.98
Received: from mta0.migadu.com (out-98.mta0.migadu.com [91.218.175.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBD8606A321
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 14:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EBD8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HaEbLixJ
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=de2c8SqCZj1+J8lbc6AZ+V+T6yStst8q4RNxh77dvUs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795876223; v=1; x=1796481023;
 b=HaEbLixJcMrqASotYvRvECfGGJUFsSxVSFfkzQMnEMz7XnqfYtIuOMFkunh/p6nVLQ49DDqT
 rjUhh/2RoG2xaZLNZfblgS0Itrw0S/dq0Pkpt+u8/JgWiq7xqmraDkck7yL/xebmt1IIuRYTqFu
 znmgq+dxSNbmbfdbt0BM0s5Q=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 52ed384f59dec9ea;
	Sat, 28 Nov 2026 14:30:22 +0000
X-Mizu-Trace-ID: 52ed384f59dec9ea
X-Migadu-Flow: FLOW_OUT
Message-ID: <506cec51-53e0-4e0e-bae3-b34dd231ce7a@linux.dev>
Date: Sat, 28 Nov 2026 22:30:15 +0800
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
Subject: Re: [PATCH v2 17/27] Docs/mm/damon/design: update for report_made
 probe filter type
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>, damon@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-18-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-18-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/24 23:36, SJ Park wrote:
> Update DAMON design document for the newly added data attribute report
> existence type probe filter.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze

