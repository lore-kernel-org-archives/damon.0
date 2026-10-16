Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9454C4FDA71
	for <damon@lists.linux.dev>; Fri, 16 Oct 2026 16:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169159; cv=none; b=qlhi1RCeHM1HCkDecWUUgswWkuk7KwtXbO8CXZUQMXS8oXn7Sw9rys2Ogy33O7PA9/wzcG593h5Qop4beJqFAE0LbQNeVxtvbqjbV/AXOrATPc4f1qdB627Xgfc+zNaKOGfzdXxnpVAfVVJuvF7aBGBCamleSdt4fRkIb9g1CEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169159; c=relaxed/simple;
	bh=yWna3LGyk7AO4Z3H58l7fcPnAfl+aPw+asBmvCYoCyI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=mrEaV/sXuLv5npLba4yL1+4R6luC9PUkHnAxtNfgTJy6DbAVGs+o3PDdvKvKVQSP+MmlGXP20uze8jD9DZQJISJb+1KAfoQDtC2MUUNX+/SXFtg7NvnoKD1EUecCo2RX/HrgO7GsDW6aIVdZnDwyXgcS537LGyB9vIuye25fNIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwZUd2ar; arc=none smtp.client-ip=74.125.228.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwZUd2ar"
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-cd5cd8e8104so38800a12.0
        for <damon@lists.linux.dev>; Fri, 16 Oct 2026 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792169158; x=1792773958; darn=lists.linux.dev;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yWna3LGyk7AO4Z3H58l7fcPnAfl+aPw+asBmvCYoCyI=;
        b=jwZUd2ar6fpEe5Azj2iFHInEP0xGhu6sUB1xkVgYZmDKaT00rSdBfcr1Mrqhxbty7R
         CQwH8yb7GLLXB0Ga5SYqsTA9tjB1GvfvkxYFb5B2FgnTqmii7U6g0xTQ4lPdt3RIPqaw
         WAprCgQwkOIpJSb5qQ39XfMAWxUMaEmtcxwiRf1gn+2Cd9oQ7L0mxHgh8tWQxutdgYPN
         dk0KrsbclhGelrDJ5UFkuHWu6YInfkFQqHyCC14N4vPXDcT++riCYdx/5L20Ls9GcbwH
         /OKWYEXfZaZxFT0rZs75Dtj9s9EYwwAFnKplZKboJfv6OacbTiefR2a0i/H8mugqlx1a
         LvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792169158; x=1792773958;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yWna3LGyk7AO4Z3H58l7fcPnAfl+aPw+asBmvCYoCyI=;
        b=e88JvXgcidUhHJg2xu9thD90jOiigwX4wAQf2lO+oEYaD/nOnscdb1rp/WKUT/PqO7
         gdO9NnXNlTreJYicjvVVMMHR2vH/CGKknOmqbWuG+Bx2sTPwX3gnExT7pe05i1cTx2gg
         9sKssuAnu4FVuPauVmrHgRxXmStf4vjwCP0df87QwE96hvF2tsWxKtH0nje3UPRRW1VJ
         0O1vJr+3rz2ff1tbk83nPyklpWnunbwiHXWrpz3PYqQ9BZs2AYwYi+LwdqBGEW53hQzV
         fmjRRFAL75gugvd3oBEfShHAyllMZ0LaMtxpgp7fPjI7nztB6O/DyDihZAB1cQ+06qbV
         7HeA==
X-Forwarded-Encrypted: i=1; AKwUvBwJzJomjcCpbpsGDhXbXL47g7x89V/w8qibq+m5BdPVDHM0AwHxSMjSUwudlZPCns+0i6h91w==@lists.linux.dev
X-Gm-Message-State: AFq9FYI7omQ9OacRy1c8q6pgCu40+Kez8SWcbl0DQeG5eG8+MWGemiaK
	hyYLGx8D6WLkORXVad6Wv/+JoLg84fZxzSl3dhh6e9LPCETuGvSO5VaW
X-Gm-Gg: AYBFou0VXUtUHMhbYiAS4UUUgBxYY8PuMqLbXJqHJAEAoLJM95cmHr40q+ikWKa8lVT
	eM97O8bdvE5yCrSUlF2YEbpDbk6rbyvCMYazhiYoE84HbDL3Vw7bsb3vPcCta/UgO/XiPEwSeg9
	wrlPTL980GKmxIOZQYOVr4R8roCrJvZgvuiGVJFIR7Jiz6vUJbQHsknKC58gltQUN4RC+oRub/q
	RxmbIxCK2c1R/rQhgAhGyBJBgxah65OdmodXzC7xKiXX0CBEwH6sZtuelCGrRpIAc+aafzdw4r7
	r/+UGe37vEgMpVorEwy/G27L72WiMPjGSz5yDkix78E7B+h/EKwSbIzsrzdkZNTQv2aCDqg+fwc
	sF/YqZ4q5kOShOJrN/9CxsnE/nS2iBizyGw/P1QQaEvX0iJc0WH9zPM5gvQJkZCaK1V3BEBq9io
	rBu5wfdxm5iHpJOSxntCjRP8PBaO3EjyUSiHMwZ5xJu1VuJ4JpOnp/V1kDDKPCZO79hizCrLnfk
	qxAKWGP4yJHgvkvP9vVrfDnIMRaPMpCnlVXeoCn4rTvLaUL8l9qU0zE8hB+ucP2oZFTA15jKfn5
	Nwg=
X-Received: by 2002:a05:6a00:2355:b0:89e:3742:3e16 with SMTP id d2e1a72fcca58-8a04ba36f4amr135378b3a.18.1792169157872;
        Fri, 16 Oct 2026 09:45:57 -0700 (PDT)
Received: from [192.168.50.20] (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a010b39a37sm648600b3a.4.2026.10.16.09.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:45:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm/damon/reclaim: improve grammar and style
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Aveline Noir <jm5905938@gmail.com>, 
 Manuel Ebner <manuelebnerli@mailbox.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, damon@lists.linux.dev, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261016142921.126622-1-sj@kernel.org>
References: <20261016142921.126622-1-sj@kernel.org>
Date: Sat, 17 Oct 2026 00:45:43 +0800
Message-Id: <179216914308.58773.4774391289742300524.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1792169146; l=369;
 i=jm5905938@gmail.com; h=from:subject:message-id;
 bh=yWna3LGyk7AO4Z3H58l7fcPnAfl+aPw+asBmvCYoCyI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgboJ0y2WZIrQV0H4HJI1WEQ5sxS6pM
 Nc/XEYGLW8ee6wAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLauXbEbo1Z6pn5MzDJimI+ZcqaQ2pweWmRLgCUWN9HvAatbqa+C2vTY/zHaGewbHARInlDH+zY
 6fx0IcRSlJws=
X-Developer-Key: i=jm5905938@gmail.com; a=openssh;
 fpr=SHA256:oSxqik6Pl1M8EjQW1QXKHoylm1jy0sguOWFFJlA9zf0

Hi SJ,

On Fri, 16 Oct 2026 07:29:21 -0700, SJ Park wrote:

> If both of you agree to my abovely suggested/agreed changes ('s/page out/ pages
> out those/' and 's/records/charges/'), I will update this patch in damon/next
> tree with those changes.

Both changes sound good to me. Keeping this patch focused makes sense.

Thx for taking a look :)

Aveline

