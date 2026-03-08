Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C61524B28
	for <damon@lists.linux.dev>; Sun,  8 Mar 2026 03:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772939122; cv=pass; b=O8uutjkcKCK8ygMWrC5iPTNkXYbldEqRs3zE2Uy8aooeZwDYCI/SvzwQMn71xtBx6U2k90SMftfPyG+6Tf9IWY9AsMkt70npxdrCkiargVJs5trNIyqS1fVH72272yQE31Wf7ppwzWEdIZmqEBSHV8PpaXnh+fufa+6/V3X11g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772939122; c=relaxed/simple;
	bh=XqVF/p+ImAQye2fndI2NjUpZzhPeVdmdlRhtFwnS3FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWYse+jW/HF7ww50jbui/vr9IO6cOShIR+0lCV15jcdGxrRYDmG9biYt1juQwii2mFWfEvlFmimYKK0NjI3I+bVaEumn85ODo3yLffUUg03dpWbXeX68kMJ38PhPZ7g7aZM/fSTWrMeIjuj6LNO9wv3C4LkibozPSMKdCMLMxa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNYxPgCh; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNYxPgCh"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64cb577e79cso11212466d50.0
        for <damon@lists.linux.dev>; Sat, 07 Mar 2026 19:05:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772939120; cv=none;
        d=google.com; s=arc-20240605;
        b=Dc0zXHAvKQsDvrY4cFokPubNHUXGdFCKz3SakzWx8egYFNI/qPvCTo59HMAK/PAyPB
         8alDfWgF7uC6m/KQXFmWXHOWnqMf0LYqAC3fYbD3nI2AeoYnOpcT+TU4vWasxbDdbBfB
         dHSrvM2gBfHEOpQvGnhUKiBh8Q6xfIxWUeHvVHZQKAI1dzELsUQKVDiNWL0BTA0qtQ4r
         hyxtkK3vLZ93IgseHRU3Vxjlmdj/9UNiTGs7ZfqaUKbXydjT/m7jL6c1ihRHafFFR8Bg
         RAAf+M13Zv8rWlkWkULZhA6INc1iBb7f9/yejJw+NVoyYnG37YqzYmVL2Djwvd/gYRbl
         nXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XqVF/p+ImAQye2fndI2NjUpZzhPeVdmdlRhtFwnS3FM=;
        fh=aaQ7HIlFw5KssijUnXYCa77DDl1vq0hc0iV0GaDejQU=;
        b=kq0+Oa2rAibv+Sjq/SrbSvcLraMpG96WkXrpGapgozx4J2jY0yX6ZX29EG/kkdkTvd
         ATbeA3x6cE8MjbzUnBxB/sJPZ68sVL9Y6DV7BdOLs1J2/TeWKFlSLWyXzn121z+WUM87
         g31YNAdRc4C42gTa8npCyW8Px0XMV8z9mIo0uhYbQPvFm0B1m7veUSgsIp/zFnZg3kNY
         ISFNQloNzfhvNe+/KCAsogT7N07dRgmqDKqkSCDpZGa3wFB+FBj9lNBr3wag7tH9cYl+
         x93Pz/Cg+lly33k47BBjMUm96ObVgdhgW4okRUYi0gNkJdQQfhjhsS3whEyRULE00Du2
         jLAQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772939120; x=1773543920; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XqVF/p+ImAQye2fndI2NjUpZzhPeVdmdlRhtFwnS3FM=;
        b=MNYxPgCh0ueElFFRHxn8uPn9nvIFUosZvYkX3lGDV/s5J0gr2id03ZHe0wr9RyBf0b
         OPPt2n+w/Li+IAkODVEfk79csiStk8Nn/iZNSL0rd1Ab0ip4lT551pEKX/qqBj1T4VaC
         RbJyGLViDfuEqk5Vy4vKvaFJYzWF+S//iBWcmUshtaOuviLieG91VQttoQ+9mmh8FbD6
         LVtqoE9D6TDI5s/v0wy/XSqCWyRObisFpPfQlpitFbtcRy9f7XDcbYNHz66Pt0ka5Gus
         wFkAicqEQtl8m1QMWL6C6fcUm0wxy8nMuH7d6XozRoyyGbVZd+ZsPwIhWMWMKel/Khlh
         GJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772939120; x=1773543920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqVF/p+ImAQye2fndI2NjUpZzhPeVdmdlRhtFwnS3FM=;
        b=RXsOkIkVfGV6VuHnSgN2EREJo/F3iMvWoHrLxan6HEO8qgYjIGDTG/xSPBr1B85qFp
         /dVkL6kB5AFAy0WiGqq4On29CGrKatfNFky3zoL1k1JB0oiYFUrDKDn+orkrqtDAkVuE
         k9RVsQCWVZA6RNG9H3gbbC+bYOORwicHfbxxNnW9id3ZYIprmUXpIOD3LmnxXIOQNsva
         d2DxTJF2HDZaZ8nOAiPRFjg5qQmvAPqBzEYsPIwcg/t9UrRQzKI+5N5Uux9kOpWjHlWw
         3O861eUVbCWxa+RmHFCgeY1lgQCDLOk7ZFOX3qdocbsEMCy9U0XH2eQfQMtQrObjaz16
         9EhQ==
X-Gm-Message-State: AOJu0YyMDl2I+CNkYiSrvpzQWOO7OGt8hasGalW6izdAhjzVRd4C2TG5
	C7NZYhX9yed+y6JK4DbcMb0zMBdxvZSaw2odxoC2vYSVTtz7gBYQkz58f5kX9Evxzt3+KRfPZcU
	AoOhgOGMacmEUqyvAqXmzxdc+dSDBQq4=
X-Gm-Gg: ATEYQzy8BFbRFhIDDQueSVu2NA5JgN3sND7ZaqaKJzXZLUH0rrktxtP2xQ1nu01jW5+
	vmvCJQ7aHiO6aCGBSxGDR46y3YzgbrhfxCIKKfVQLQPyc4eS1bon/XJBFuL/F/7fW0N0ku4/8RD
	FwL8PEmgYcFerXqcueizFLXPHylO7Q7PkdR6Dkyht+hzBuORwcteMJpioTDxnDXDYIyT5G5HTcr
	VvNFSfS8sSn9kngUV6rohO48RV/REdc13oYr7Us9k7mMzLmpC9Svc51q+oJPQWj0TmqvV2RAPqk
	j88rWY3Mp/pPQZYrpGnqMSIdkIQuiiY97LqJdxvu9w==
X-Received: by 2002:a05:690e:205f:b0:64c:a0eb:c4b5 with SMTP id
 956f58d0204a3-64d14293d66mr5095532d50.52.1772939119973; Sat, 07 Mar 2026
 19:05:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260308021811.41199-1-aethernet65535@gmail.com>
In-Reply-To: <20260308021811.41199-1-aethernet65535@gmail.com>
From: Aether <aethernet65535@gmail.com>
Date: Sun, 8 Mar 2026 11:05:09 +0800
X-Gm-Features: AaiRm52I6jeA7gxZoERyr5HYwntXkI-cPR1yC_IGGfyUOLCoDxZg9DJSDG__lis
Message-ID: <CAPLv50pFasDAnFMX8OgXjo2Nrn8rGhUgm1=K5aOeVyKf57Z3BQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/mm/damon: fix typo in index.rst
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi SeongJae,

I just noticed that you already submitted the same fix for the type in
Documentation/mm/damon/index.rst. Sorry for the duplicate!

I'll make sure to search the mailing list first next time before submitting a
patch. Thanks for the quick fix, and thanks for maintaining DAMON!

Best regards,
Liew Rui Yan
