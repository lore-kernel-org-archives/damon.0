Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455514;
	b=plhbb6KbGCQY/OJkw5vCODt+vJ0Y+Xx3rTzN9IduH73WwOcGyf0bBG2es7pcVFK6ZXQH
	 b6BxB+f8pB7fn1wDN6oqeWKfC69Nkw+3eFdWpflHNAeD2qVMDcAY3yFFbpxLqpzoNNYFX
	 vC967zG5RwZF2Juk8nFbftlhCHcEVvKVXD8h5dhRN9HDBcmGjLq/vlZDE/tzwM+ttIcYK
	 HQNZdhCD4UGYDhoqxUbtO9W1mS4M+0qxd/xo+ba+bNNNZzG6F25N3Z274KqLEgmx4Nrr/
	 UCBseJ8TdvRlaSN4MkZh2SNev8Vj+k52vq2cPoElzVu4jDaB5xlUdEaE4v1nNFC17CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=byWegylhHUbUWvI71Abrtjm94VdQoqKOeR3WzBbTjQM=;
	b=1MDZ/V2he5i+SaMqlRMOOXneELWEJfgqnKsmb5G3PTsmmtmH//kbLaI2+oVLfYfn4leE
	 aAJ0q7tdrZkfSrXi9EXazaA2i/95H/SyfvM9MwNOrTkUv4VxjzYQcaHYHt9NC6YlH2cdh
	 kAwnYKORRI9TfYTOPYIZtCIPVZyJVjMrSTs16tQOdQwctw0Jrw7oBviOUwPDfHRRrml1/
	 kCtpiOYSjjIMFj0Uay7413UyyrnrxvL+YitF3CJUin7+/JJEGJlhfMGvIqBl1ex/izJVy
	 yBGxpcnHQnkHzw9OiANLjlA7OGhRTfxpzo34zDIDJzEhkRatwIocLO55Kxw3FoDRhuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UB0CsHvm;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7255606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7255606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UB0CsHvm
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3862cc30b3aso838925eec.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455513; x=1796060313; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=byWegylhHUbUWvI71Abrtjm94VdQoqKOeR3WzBbTjQM=;
        b=UB0CsHvmZXR5QZKL3s8ec9KzWTcQIANae/vkL+mVOxCn4naRhSYTiWxPFNajb+UImp
         CZuMxsdcSKv8fBZdDK9vm12lJEd0r4ncuZXjlfTDXRTBmho9DbBFHwjVMB8RuVctwWYw
         03HJ95hO8kcFQqAF5uXeafCJlYdj6KVzyBlAsX6rcxQesdpbKo2o0q+Sxq1WubIlFVYi
         NStj0cc3iGKfUFXUWj+b+sPkyWNwh2BIR5/NRbPb3pW+6LP6JGD3k6Nu8VNRv9S55V5+
         rajyfmeic6iFUNuFtffoUJwprdqe6UmWxLhAWewBvZmPIZv1pSqbPMT/V7kfXUugBfJL
         2D7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455513; x=1796060313;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=byWegylhHUbUWvI71Abrtjm94VdQoqKOeR3WzBbTjQM=;
        b=xOUttFnE12NyM/NpRceI1QlTNyyyE8xsSc++tlLWu6JWHbwzyFm3mCHN6WpZEfDc+y
         x3MqWYlLFfqmYgUOyMlEGx3ALMdSCxO34+bu9ejihOjdkpCt0t3eVinynLgbBxSG8Ss/
         CH93sEeArICQ/61n6r9k87VgRZstaZkrSD0hqmWV7nX0mQw8r3l6TE+vNbJ/MDjsEfLP
         7fnyWUTovy5ZQNn/jmdOL/Q6YQ/OJREK+Cz/f1dX6vKqKl/hueMtCT695SYi8bGY/NAq
         G5VF4mYpNKYS0IgKwoReXukYWRyp5Vvs9CY7uzgVhMEugMu1D3b7eI4uuC7/I3AoPcS2
         6jKQ==
X-Forwarded-Encrypted: i=1; AL+hErEtIBOX1XpfPllRsT59cP79XwzziPyEuPx1GhNCX+BT4FUYu8eTIXkFqzdJOjz/ZKwaUd0H0g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8DJyXLnXWF6ncTmXk90w5UV66jGyp5Fk4PRw8PzQ+vKdXiRoQT
	iocVu4IUAI0GVPYFTsObkm3y7zy8kADLpfkIm9bf0eviZKtOBrZCNkj1
X-Gm-Gg: AZFdTZfIAbxEqBs0thn53xZyxYuDN2A1JixTUo2fEU1pWAEogGdjCo8RAbVzcDwepG9
	EI243rk4wwNgdAHpzdfRiWof92KVGO1Punu8U5TYolpzBLjnuJmNC7xRCwTDLn2Y3bxMwXoIm6j
	TxN3XIXUcyo7AZTcanu5Eh6x8rima+jq9S4p8WFxi9TQVP651NLgrwIF4B1FtJ0VipRXircWGl3
	lekgl1oJZFKfq+PDkT5iZXAs/RpB2Gvg80rfCtRVeBB2sWULyKAtkirvN6VxARPOCGQ42sD/Gmj
	O8HykX5wY4/Hx+tzRHCNi4DCrm/jkQOzTYpNedd+PPaidrQaEEyFfrjHxcxsubJRiWfGLxt6VUT
	5dz71iQK3VxvmWrhKp9biLCmhgYHsmOq5cQeWSE6yo1MGaaqRguLT546NLPz7RW50vG7v+AtWro
	VpuiM/KJZJJjYbRfs9MPA/LiGCHzd+G+ywBFP+PInCUG2DupINjFmKFVVZAIU2loFK8fudXDr3j
	5WAFvkgDsYgAvR8/cVjbHZa6t27Ve1Lh4tIqogVFfGvxZlxqUlVWu6fHQrveg+O+1ZhVtTYggxi
	uU67ShJJHJ7RdwLbpEUmj2ZpWARdvwszVwllUZKEe82HIbD6iitXNJjAaBMIsdI+UkDgIxsfrhW
	YgLVtd/dlxJOg+GDSuQ3i8N99TkQTUEigkq+QJgEZqNYIfZIjNzrBTa+3WZcuFA==
X-Received: by 2002:a05:7301:3d19:b0:376:ce6a:a499 with SMTP id 5a478bee46e88-3857122312dmr17032452eec.36.1795455512534;
        Mon, 23 Nov 2026 09:38:32 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:38:32 -0800 (PST)
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
Subject: Re: [PATCH 23/27] mm/damon/sysfs: implement submit command for
 report producer
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:24 +1100
Message-Id: <179545256492.4.15675648652797280437.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-24-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-24-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 13:00:07 -0800 SJ Park wrote:

> Let users manually submit a report of a data attribute for a given
> address range of memory.  Let producer_state receive "submit" input for
> that.  For the input, generate the report based on user inputs that are
> written to the appropriate sysfs files and submit to DAMON using the
> core API, damon_submit_report().

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
