Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455360;
	b=uzITZRFA5JwR4HntJySkf56G5AfJLhhsnsJ3BIbxaoaZNuUBoWloBwE/2hBkvLnfP8A6
	 zcPxpIJCmoCHtjXfJUegXAKVA3fEHmWnGCrdVf216VZEuwZ0uQfYfy9oq/yHVDi+yLy6x
	 2ifRI617gNyV4oV/fRRw7JPDTWDgxwrw+Tw2+77FZqzei36cBZO7x7yS9pCKGCRmTB7QU
	 VHsqWBR7VKwvRCD/HBAP20RKbp2Va3kGaHtgQT0Pk4vu5+dGVC2cdTNGj3O8yzKPgHxMO
	 KqV9+sa/nBWO33cAJgCEnEpp+8mvmDaRES5TJVjjTAv+DYiNzL82XECZbYri36J28dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=PHHA4/UW1I46SlD7mVUoQdEpZOeV32bGQSJyTeGuf7k=;
	b=vo993Bd6ECZOj/p0WuFntjHLOMArNjzbDIuean+Ql62PtBa0YqOKSVS6qBoAX9sgb7yw
	 VYkxYJhvY2O4zDhV2c4FZm+hgpbD5tFwk7FO2urkBZWmpRuraOPI4OHomXMD65rcovVKl
	 LucfA8+OC7v+AhJGI50QaD8go75jwDnUHjzUvVy8mnsMPlZHRmADHuedKLYuR9IpMjP/2
	 ycFV+ECQRnrOpTxxwrwILokrkPo5eZo+R3pnPTu0aEBt1aSZjSL9b0rre9I3FaB828Qh+
	 DuMvtYFyc7KKH4pPO3lxpK4qWD/om210nmaxd+DTy6VpAtQuLXwHLm7QUaPWAxaeFkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tImAqU9n;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2E2606A31A
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB2E2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tImAqU9n
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-384d0550c71so2046685eec.0
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455359; x=1796060159; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PHHA4/UW1I46SlD7mVUoQdEpZOeV32bGQSJyTeGuf7k=;
        b=tImAqU9nELoN93C23b7JZMWahqmpx6/hzDkGHgnxE6PCbF8bz0gyzTxDImlvI7IXJT
         yXnMUq8wJERbA0jI5fW1AdE9898XnFcT8S9hjgyvj8Pvmn6Hg1WQuvpqbmum9K5i9Rco
         NGYM/0sRyX6RUWJnl9UP7I5jGmD1AIHVwo9/kz6XelipAaS39/aNk9RPmKmvS8nLRkX5
         p8LiSdY00i3NMeJYAARAQjLwjcOMW4EH+voxNul6ISZoOQ3J1V8OlsfoY5TX2jz9b1k4
         Idgj32O185vIlygzSEVgJUnyNby3h3w/KHvY+avP2ST5yImGSbRHBS4eh7nIzRZoSuFY
         G3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455359; x=1796060159;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PHHA4/UW1I46SlD7mVUoQdEpZOeV32bGQSJyTeGuf7k=;
        b=WkjOYf56LgBpTu/N9d8zNSz7ZsmHr6I4JJkoXY5LEJvFaJzhgwdc/Hd4e96ovYwJG1
         svXsoaksxVnWt1kaANjZYuFRJlkURUTerJBAJyRR6jQcaN7Mcrp8+9/YjTD7/38pHbWj
         oa7205MvK93FHnqsP0hxOuRRPoLWzbwwKVcbw0QmLQ6dhXFyKAnAS8J/XMZmmWBkfJhV
         uR8ZFQdaFxoTCAmPNtiuTR1PfijTOgZmfHaXqrNt4C3lpBGm/CeZ2romvT/5W6n2Pmn1
         s33OtzesQQLxaMbMARfr/+YveylrJvmDZnVUQsueyruz3v+cjcNN+ik6dAsaege+P6EM
         LDVQ==
X-Forwarded-Encrypted: i=1; AL+hErGuLT5FeVsWvmjpuBkewcIZIB71YF6597LIC9vodibPVros++vcwOcdULnCcS5OeH9O9mgZuQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/bfCSMzTrCWokI0SUqKz6oAlhaRDtIwf0ghpeQPsHfwtocmxOp
	RdD+c8MfSKiLHoFmQCdm2gvSTHWsHClvnVjgJDGTGhh3PJRop2oH2jDS
X-Gm-Gg: AZFdTZeYlYpq4Vbh5aRlqYEOsmbgao7zdVrXiRGKc3bP8CzE6gNk6Qd4BMJylkNGR/Q
	oN4zBh4PNY8YGZlgPQbZhFYd9IMYB39OGwb5NhbLbuwKHQY28KHpl6m/Jn+eVhW1lhLkQkPZazq
	l7BEhJFB/ANh1qoaQ3GtqJDAtsPm36zwj2jiQfVLzK4E+NdJ8MecQN9Y8JhK4AIi+xv7szF/WpV
	JYQoWY2irLQ8cyE7Kt6xvEUuGJBJbyvLVfrx2QWLgKcdL53OSucquMMRbNZJfgnCjsv6RkdvzT7
	cB4dGrMGvo2FT5sCmCQsfyhbr7iy+1KfO0vSte/YRXHbv4q3EfNlI1Jvuqd5KJ52k7ruVXrz2gj
	6vuHXLpl8uNKYUEQqDH6EXC36YkTVo0SE393ftFtz5qVY4wzUukMMMH34tzvrgXnybl7Yh+jPSm
	ysj07VoStg8Cwtbm/W07LaROjujFj0cAvzbJI8S/k90LufOyn2WlNcY8qdoBxP7ZuGmDtQST/N0
	K4U5Zd+2Ls052t7OhHVjbk8CAfWkwGWvYr/tBh+Jf+feGoccEbyBYuuHjAJAKJhl7My2Dl19R/y
	8pDCXRmSuxWqEgsGcvPlLroG4rgX4tboCiIw8yY7gIfRaK8GYiDW3xIqBPJq9Z0iyTKy2xlV1D7
	+DbBVDIFZW3ijsuDUU6GntTqdE127wo2eCBl5nf0Ii+s13siBMMYkJ78V+krxVA==
X-Received: by 2002:a05:693c:20ce:20b0:37a:a9db:6bd2 with SMTP id 5a478bee46e88-3856e63b064mr13581504eec.11.1795455358808;
        Mon, 23 Nov 2026 09:35:58 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:35:58 -0800 (PST)
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
Subject: Re: [PATCH 06/27] mm/damon/sysfs: add producers/nr_producers file
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:25 +1100
Message-Id: <179545256507.4.17207740152936961062.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-7-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-7-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 12:59:50 -0800 SJ Park wrote:

> Implement a new sysfs file, nr_producers, under the producers/
> directory.  The file will be used for generating directories for each
> report producer, in a manner that is similar to the nr_kdamonds file.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
