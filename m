Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795879431;
	b=3eM9CVktH1AQDvaT7JEFolS5txRFql0YrVSCawtsq2gLlLzcD8ZyLsE9iSwhDq9mGLAs
	 04/DvIzaOSrbntcgZoGOCS5deyrYC3SKCPyjNeLi5QUcGdolH+pbIevWS5SUglu6WHBEY
	 Y4c8L5/H4wCBqpxiw/fLsvs6BW1sI2dgMp9OKu/C2P3i2sTgyaMuUdurEXmsuUbZmRpGX
	 wu/F5fXL8PDW8+0u3/R0b8bA79Jb4Jnr3SAr3TCzE+r3gG13PIdfx7fBTV15W8xF76rfu
	 cQOJxapyG1xJMuQS/4wdqeKPLtJ0IkaBng6WpQJzPsFCVcF5Uo5LqkpIhFvzfx3sI2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795879431;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=4YoytxbkydaKisCHzxvStQkegJXD59ztmVMjbW0PKus=;
	b=c2LawBD2tpZJ0P8Za8quRyeuercqXuwThGssJAAdeyIe4Ktkoi4LtXDRDSD7OKXfLJxR
	 64hlOn0ifyNNVfsWmjiV90sFSCVhc4YdNNcnSU+7B3W87DWxs64ABm8cW6XWbuPF5sRZw
	 gYtDHdnDpZBU+cKhBdIaycZzlsjABCkMRkQvaoDDAPEjLhiADz/ZVnabmOwNIlqELqun3
	 PTaeU6JuyEtVPe9+7RxqIo5oRU/W3cmQj3H+BlHLQiNjnmibgw3la6IULyfroIzFKK1iA
	 bT1SIcu0Eix4/yY40+/zfAm9EWcIb91xZnbIHvXP+odh3D48LWR53fmax2fSIUAA/Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K68rqGK0;
	arc=none smtp.remote-ip=91.218.175.236
Received: from mta0.migadu.com (out-236.mta0.migadu.com [91.218.175.236])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF93606A31C
	for <damon@lists.linux.dev>; Sat, 28 Nov 2026 15:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EF93606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=K68rqGK0
X-Envelope-To: damon@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=N7wrA77K0zeZvH5co7+V5zkvxNQ5xOh0bvW3mSQtKkQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795879429; v=1; x=1796484229;
 b=K68rqGK0lfCb9NgvAtrt5ncOfqu9IkWqddqsRm4tWExO0xbViXinrzAjqgKQWPjZ4ea3X2IR
 /4cfE9hxnlOAkp+vZ67dFoVJTP5Y5vrVNVi3PaQxPpEae7XdHf7MV3ztMSKb7GuR+hgdbOK4AOZ
 YqHnXOd0GHdL8nnXafzeepVQ=
X-Envelope-To: damon@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id fd1042fe108e2622;
	Sat, 28 Nov 2026 15:23:49 +0000
X-Mizu-Trace-ID: fd1042fe108e2622
X-Migadu-Flow: FLOW_OUT
Message-ID: <09e09540-09b0-403a-ad5b-7f4bad125fd1@linux.dev>
Date: Sat, 28 Nov 2026 23:23:44 +0800
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
Subject: Re: [PATCH v2 21/27] mm/damon/sysfs: add user_report support for
 report type input
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org,
 Aveline Noir <jm5905938@gmail.com>, Lian Wang <lianux.mm@gmail.com>
References: <20261124153636.91854-1-sj@kernel.org>
 <20261124153636.91854-22-sj@kernel.org>
Content-Language: en-US
From: Enze Li <enze.li@linux.dev>
In-Reply-To: <20261124153636.91854-22-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/24 23:36, SJ Park wrote:
> Extend the mapping list for data attribute report types and user
> keywords, for the USER_REPORT report type.  Use "user_report" as the
> matching user keyword.
> 
> Reviewed-by: Aveline Noir <jm5905938@gmail.com>
> Reviewed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: SJ Park <sj@kernel.org>

Reviewed-by: Enze Li <lienze@kylinos.cn>

Thanks,
Enze

