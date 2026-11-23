Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455489;
	b=TI/rMV+j/I2wjbD4ExFHaawweqakaQcq/peuH3viSHbZSYuwcg2gffEgONY41NyAYAiZ
	 PPnyrh31aM9oLxCJz2NK5IyiKFob1QpAyoB98rHmmMFLeyFP0q6ooVCzOP+fypR2jqSCc
	 W7fZoXdozmk7cucOA3wK11j1Pu7+9OuLDnmTz20laOXeti52eUYhb3udBZiAKWNXiTYA9
	 lfCVC03xDDQhwfWwJktxfKZlGJWKr2rP9bVQigLhTIbYDxhECw8TSqRD0egfFrF7s+HnB
	 pY3l6RnXjTyGOMWQkvA1CY55upS+gofgtqhE2qyeUy63G5UqnZgqr49947foyYTkI/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:Date:
	 Message-Id:To:Cc:In-Reply-To:References:X-Mailer;
	bh=UNprIaLuwx/PIfm0T+TSNXckbwgMyUXMskfrNB0wgSA=;
	b=bgvAH9K2aKp9wf5Sj5oHlFKkEpHdNKhA2eZyeoPAZUYh4G8AIjdMOH3UwTqYrmdphFzw
	 Emut+oiAOeFW4mIf6pIYIpiVZt0knXo4ouMvlUiEIOalrNPtUJPTBVUNzHKj8josdVH++
	 l95sWFCYXsIt9zSG4N6uWRzYHB+402PrVATWOff1TE5zY8Ogu3MY8bX9W8PfpHUlLULzj
	 4k9ixiBGx8vqJE51nC9p30pJL6UQXFk6R6tSw+vdCnDHYZJkAv+5IaCAiXBdX24XAROU5
	 +a1tGoua9Q5LQ7p4PvuVTPgK8QU6GCPhUupdtAOmdmuarCnGOApZw8d9QzPaqR2Y1kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OuX9n5tX;
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EE0606A31E
	for <damon@lists.linux.dev>; Mon, 23 Nov 2026 17:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35EE0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OuX9n5tX
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-386a9c93b4eso593292eec.1
        for <damon@lists.linux.dev>; Mon, 23 Nov 2026 09:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455488; x=1796060288; darn=lists.linux.dev;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UNprIaLuwx/PIfm0T+TSNXckbwgMyUXMskfrNB0wgSA=;
        b=OuX9n5tXqNYEpCcReo3lyaW2RihNZ9RpVU0nhNLKGxxK/6pKUL2m4ZAnaOVP3hL6YA
         LtPWcvLHq68vNxbJxohWL3vqSb0HD5RvTE8r1xQo90mqGxlyhqdooyO33VgslGmTY+yN
         Z3SHeF956/b7XqXBgXfg+fDOFe2+LAKa92YKQJr0eSVFhagUMGkxttpeTdF/SOGoopA1
         wdoUJUMjPfoYkxpJD/iHAamjMQjlqyp3hWBrV4/1715I/Fl7Ce3GgY13ftJkdplZkPRv
         Ypa1LQwdtJHXHhV5/LPynwpZ/MnK6rSJ2nVnvqKTdMT8We5CapJ+aRB+2e8cFh/rC1+G
         Xkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455488; x=1796060288;
        h=references:in-reply-to:cc:to:message-id:date:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNprIaLuwx/PIfm0T+TSNXckbwgMyUXMskfrNB0wgSA=;
        b=UVTDvXMHyWi90gTbj+XfloxfDWpA7+FY6ufEymHV+1UgF8JqcLW8q2ZCvQrDBJlfPB
         /iqrKqnEOhmjUwiRYdbcND+b+uGsk/D9JEKQwqWYu6K+QioNUFhVxqAL1mE3tAVQWoZC
         YMvEL9vSkUYYFGuBU9nrHCefQWqPSw5ycbB25S1Y2b+oy9MV8bFvDJ+b73MBlt68Nu6P
         3PSXe10cy8lnlRFcQbHsQ0e62Kk4wAcXrkvZRhQCHDZf/Fj6kC5fd3ZxoDTa89su4AAb
         QDKMoHjuWixPiQjFUzwFbHK7zdckJHrzUT5CO6Hcke/VxHAcI2MduKTzfjWhQCzxPGrv
         Ldlg==
X-Forwarded-Encrypted: i=1; AL+hErEqWpS+esdjQrPc9xhM7jGu0+xuXaUtmamJzyQIdWgL7zo5Frj/J8/v4OiLkTPprmxFsI/SIw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Ajz1hqx0jjGoyyB+B12AmGHqmR+6xrc75D+7C4j3Io2EoM4g8
	U6F/+nwAEJUI3wVP44H8BOGGSmFWt3TioSetcf8DxgVl8lRDNKzJpLUiDokdx6008z8kWg==
X-Gm-Gg: AZFdTZcJ+DO/ULlnkdDmF6Ib8r+zrRQ1rrP2bCi/Gc0LxqQGjnaVJo46LP2q7LqSKBG
	GECf7WAHP9HAOsA9vNaUd7xobvYBhxcKRJfXz/eLY0FsmTk5RyXLfDfHL6YAiPTPMnMSMEzF3TR
	HdMUq1MQaZCaNVKxVqAM0NmveV2/7zPkr+tj+eOLjNZCrsrPZZyiqrof+/J5/CvXr2egWRikwy2
	6qi/3Uj3wXqci8m/HpftnIavmldrDUcEDGpreX2KxLhWfGAukll4/IN7CKcYlliiVHDr1U7p8Fp
	jr+w9TYoV7xL9PwKraDMkozDiLNy/YeiEqs27LWB+stC60JpGhA6+JqIARODXGjuj1MPKEa/Yaa
	Fts3c9/OCKYcTs7iENuj88Vdt98z/6vilLXB3CQ5iX8yMK0cbYPv169+9UQjgJIKPN2Bakget15
	zXHcQvIjPBEAPd9vTRXaed6yOCN6ju5MouNMIf11sddeKsRzPeduTORng3qoEN/qP6AKzviUbdW
	8wmfwx8LnDmi53d7QKadlQ+qHtqRb/ALUsgow1LeTq5IThiR/ZLgGjHTaWuApLxx+BQJBtuYBV0
	eonVk1n6JJRvnXkafzjSkTxFUz4hONjFBQLvuwUdkk+hGk7pqenMNW3VOzHvH6ruqXpHJH7qp+e
	kv9tXprFNvKybV81jk/JjptyzPRyGUEHfsrK0dlwAL0MdafoXQxKcnRfP81WTfg==
X-Received: by 2002:a05:7301:18aa:b0:386:a0cc:b97d with SMTP id 5a478bee46e88-386a0ccbd2fmr7820717eec.4.1795455488491;
        Mon, 23 Nov 2026 09:38:08 -0800 (PST)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567abb870sm31532302eec.25.2026.11.23.09.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:38:08 -0800 (PST)
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
Subject: Re: [PATCH 20/27] mm/damon/api: introduce user_report report type
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 24 Nov 2026 03:49:25 +1100
Message-Id: <179545256509.4.13193548537304229599.b4-reply@b4>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, 
 Lian Wang <lianux.mm@gmail.com>, linux-mm@kvack.org
In-Reply-To: <20261121210013.130397-21-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
 <20261121210013.130397-21-sj@kernel.org>
X-Mailer: b4 0.16.0

Hi SJ,

On Sat, 21 Nov 2026 13:00:04 -0800 SJ Park wrote:

> Users could know some data attribute information and willing to provide
> that to DAMON.  Introduce a new damon_report_type,
> DAMON_REPORT_TYPE_USER_REPORT, for such user-provided reports.

LGTM, thanks.

Reviewed-by: Aveline Noir <jm5905938@gmail.com>

Thanks,
Aveline Noir
