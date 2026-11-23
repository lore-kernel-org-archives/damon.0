Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795435462;
	b=vJySJHtpuKitzr1V6n6XFDlX+hd4NS3WOurnN1GLz9b/im8ZrLwL9GRHKlHrS70v2Oxn
	 09Esn3qT4KN+dxQPwsMFIo/EtYGejwFneMb9Abha4nNCoBxsGq98/7hpkl475Q/tZrl5l
	 DKCT5ifccnFAC62Wcq3t6+X0K+2BWt3wOcGj5shX1tG5XGq+FNphRnZqqH0Oq0Mzxob2H
	 tVjNhxowGWpZsP4LPsC1wm831APYimj23oJSX6+3pV3uKwhOZypU3N8fOOrBmgaqGs8VP
	 jXbam8Omdvd5wB9RG1RZnQ46o1BbgPAGd0xlbkFFHMPJIcUHqiQ3CeOGA0dhddRc1gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795435462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=on4OwLeblNaonT3lNV7MZNGdksvxJ91EU4BXLnkFgWI=;
	b=2hGwfKu43YLPanQFMsuBJKWryHIg9l1OxFsU8kJrxvbHlo7qi9sJmpqdaPHh3lruoW6p
	 /DQQj08EjOjepH0a8s+PSozplJ3CYSSqC0RdGg7lrvtMl7O1UX08H3FbPfD9Zgvo4sUmf
	 gwiOiNC/3I0cX+I6JPSgwqw0moMrUwNpNbc9FysBI0PYTvyVhr0t19QIlM0LCSgm4D/eu
	 tx5X2ZykxHlVn8ikGWekoHC7HdWhJBn6MBC1RZ2cHswBuyOiaQSlU4HEyhvvXhMSkvPMH
	 eblZ5WNZEqJHZfIC42A39M/j79hrFLlWxVPvM+/YtF+fB6GatFsko1jPrkkkA4KLmiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pc3cOpUM;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85565606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 12:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85565606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pc3cOpUM
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-380c28f9e35so4283939eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 04:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795435462; x=1796040262; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=on4OwLeblNaonT3lNV7MZNGdksvxJ91EU4BXLnkFgWI=;
        b=pc3cOpUMjk6A0gbPScvulFnvC23Id1p0l9ejmzdzSOPvkpIVovrgsmVH01Y0k5/VXx
         +ETkgihM2JQqOjjyMtynw8BEGwMueYwDHlWjW5y7lM9Z+zL+sQnc3g4CfBOcS8RoSbgK
         40YF7BsbZsIsR3TBVl6nuGyoeylLcmyN2IGAkVRacnNgKEIHTpyovmXhxw5o6Ro9FQCO
         G6pjbAIOVyO75egc+t3X7arZn3z1PzYhyA30wKeUTiixafg+lT5eKRQELORHE1ol7gL4
         CXqXVTyLubkieAWJ7RV0dPC/ClSDK3PifUEqyk0bU6X7EiCp0v8d+G/GMipjXfsBwOf/
         9u8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795435462; x=1796040262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=on4OwLeblNaonT3lNV7MZNGdksvxJ91EU4BXLnkFgWI=;
        b=edkfPCsFDtC3tH88LKHHpmxx2peiOWDgCcDlRWWubB38ZZ2gUsUgBft/F+LVq3FvTK
         1xVZSLT/rqCZe5fFdpu0VCAlgUNhBRQh5kP7KTbYWDN8AwCFvAjMKfoj4XxHygQqBEQO
         TD79LDOi13Sgsrhjv4K7VA+JnNUFto2QC20Ytsj0635zlt3XuV74vU1egNkvJgmlHNfg
         luAyUrC58pOrLzOa4/bQN36XKe5LtSjxLRcEo34epmpuKiyoLFSeis2rSScuQX+GppPB
         UkDNetyFWvVjeI0xk1Bi9/l3GT/eSKyzmlzVQiZygUEOmW3TI50SW8VhUxkMgYBBUHPG
         /PDQ==
X-Forwarded-Encrypted: i=1; AL+hErHyVu8zUt8aUeki7ayleH577JPv85fpgDTjOAbZwzqXvIaBTEqLASqeS0YbISno2/5AKkwe4g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8Py9YZmYaD+bAmYA3qARq+ofR321sNi+u9JhAut4L02DkF/XqF
	J6qu42JkHE6FitK7bjVjKCW4Lt0Ai0H2wcTi9pZCUisAqvoPYNzjiMMQ
X-Gm-Gg: AZFdTZd6MIVMg+MIOqjeOUD56clpAZYiXY3NU4aZJmcHkZYaasEl4nrHsFlx/+2VrBJ
	bq9VpyolhRNkVy1yZ9HPqmilFg+CbrcI6H2Av5AWURseUCh3r6PWKRDZiE4SEKjnTzO0e9yo3x8
	rg8Ila0gyR90Uj8b6b/igQrTtrKMhiPfU9S3IJ9zFpe+OvN5tm2IVT3ZRClTUHVPFfK8OLXvz9i
	vEoDd0zb9dNPp5UizixlrRKaCEGL6vbuvzrJU9HBmEX/6z6IfhCY+KRo7BJkHBOnA9cxHvkkD0z
	Gzpzld0GwksH2wzExB9/YcI43djM+bYZiyHhOgxZcABI3v8Xqs/cRML+/l3Cvkh6yRyGqtoMw6G
	Nyo5QdOjNhyscVx6RlP9m7V7vwGiqSkNcsxYX8OR81Xa43/ySsS/sblywFMwXN7VAycwLIdmJyG
	eRgwloaW4Q8dEM+pnv84o7R4hMtAqhAQbmGnHtDcuVEqzEXOLIhpvrF99XxdypSqanND3bjehOl
	TV6xslYlia+oSxFiAvesyQnusmga6sYIdBtB/JWYnKPy7jeUxmqufmXx5ZcDYnJxXDM/cYJmC/Y
	9C94qG1OEhx+wpiR4JJnfcX7B78CaKH9Fw+72ZdTvwAK5l3WR27blPOzdWL+LgzCJ3M6
X-Received: by 2002:a05:7301:2b5:b0:386:b8a7:a195 with SMTP id 5a478bee46e88-386b8a7a885mr850543eec.2.1795435461549;
        Mon, 23 Nov 2026 04:04:21 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm42190014eec.10.2026.11.23.04.04.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 04:04:21 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 25/27] Docs/mm/damon/design: update for user report support
Date: Mon, 23 Nov 2026 20:04:03 +0800
Message-ID: <20261123120410.9542-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261121210013.130397-26-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org> <20261121210013.130397-26-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 21 Nov 2026 13:00:09 -0800 SJ Park <sj@kernel.org> wrote:

> Update DAMON design document for the newly aded user_report type data
> attribute reports.

Makes sense, so LGTM.

Reviewed-by: Lian Wang <lianux.mm@gmail.com>
