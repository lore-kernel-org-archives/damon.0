Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793421663;
	b=e0j1Tgal2zexmR5HUdcs12vXZapYV2UAcF0zLOUjEMFJu8ZIeItXcvOAGgyjrsOtUr9m
	 bqdE8fwnxfs1wTONMP1cnsuk3U1a/Em0l4AcJnO7IQHFE08VxlYPu5ztbLMSRm9TULYVX
	 JQzca0XWqpKM+MxOmq2Z5Cp2gqY+AS7sMF6n+q7saBJrGMiokBwC/joc6f3POsGsuP+PY
	 gOJQ9Gd2KzLjuIm/CD8DZvH4FI7f/Crnw39RnAtP1VEU5yYG592+0XAHaXqO9jMEgEud6
	 xaGcfQU9Spxw6h9SB8MlHNp5auoUts9j7zrMLDZAahJeCsZ/k03kYoaVSoc5b65IUnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793421663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Date:Message-ID:Subject:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=mYAG5OYgNALKbmlFXyHbo1nyH/Yr5PiBp4YedVqYig0=;
	b=gKdTY+v8PfnsWkPoG8uhOG5rKJirTIzd+e+gs7Q7rLe67H9LHWGrd7Pz0EjdW2OU9YN/
	 wFHDHKxNTBxzH+5hQoVzR88ffEGsYbXYi5W4DWz3hbrp8niIkwonrO1wbZ48aUxOGckli
	 DRZZdNswDdFexdSJZCAn57YGHJXH0aocR3JxaLaQO6HJBDP7sRbSCciAmjkysfP2ZTTUF
	 G6ZUCQTEIAAEjX88/B4akhWkm3NLbnKkFM154l0S10uvUmhoWd9F5DY+gHHqKlMjh+j4C
	 fVyZKeG1zUncC6QHJNtyPEGj1830l/e99oUS5wDSgq1//DtRGBqNi3ohbdzi56xHQyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CDE606A31F
	for <damon@lists.linux.dev>; Sat, 31 Oct 2026 04:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6CDE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f8.google.com with SMTP id d9443c01a7336-2e93d9c7973so12488025ad.1
        for <damon@lists.linux.dev>; Fri, 30 Oct 2026 21:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793421654; x=1794026454; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:message-id:date:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mYAG5OYgNALKbmlFXyHbo1nyH/Yr5PiBp4YedVqYig0=;
        b=zSg0RC+ulGGGYulV5vR+fqE09LNQGxsnhKCUF06C6g18FtFZbbm6igLpIij2t4pzmj
         iGT189Bjhxn1D4xRUcbQiB4LN0zgYhLH3hhImveXGxg6fEEXigcFLt5gn5uVCa3yGKNf
         0k0gR+LZFs1Lxj1ARQpBp907rzcEtJIiNeMN+rfGEiMkdsgotwiu4jOP9vaywIHrVK8o
         0Nn27QsXXmaut1IsYvarg9c583p9grabw5svxofRlNyAiHOu6QBauaXmiXiUlFIpb0Ud
         +H0UNhAsxdBoY7fRaUvg1aIwHuohK0mH50MqKzjnqjys7UTUfZWO/8EtyVRDUiFAl1ht
         txPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793421654; x=1794026454;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:subject:message-id:date:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mYAG5OYgNALKbmlFXyHbo1nyH/Yr5PiBp4YedVqYig0=;
        b=H2JOiWRb+XDaWM494JkkRTh760v6C04wWPqLP3F71w108oqn9oT8YBbrKKqH32igNp
         wIBe09EO1u1iJmRcWpab6V+1GimIkOsb9qStrAmEV9nVGWZsbl27QeLS7R6GfDep9e4A
         AE1sHr3HrBFS6xUWe+XfUhHglawWi7uWtkoZLI7jiPOiK2qkKZQM31yOAL5esT/A55N5
         pPF4+IfM6UbxUd+6KwGmBe4UBgRTDt7RbEs5FyJJv7Gg+nA2zUNysZ9oUKMt6OAUN2Zt
         CRN+HTWd8xvF4tFihQV7nubVglJxOVQouzJz2OjVCQIrkUwz1j8+S19LQ/D4bkptSjyD
         641A==
X-Forwarded-Encrypted: i=1; AKwUvBzTpKmdMcna8m3O3Ova9z4lwKIdRYrv1cqQfkQyC3F15sV4BEoMrdpME4KXy9vsmFPgSRb2cw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIvdz3qUIVaVhBh8iMcTJocsEbZ3MDvTmH9JTHhrBLm4KXTNmVn
	jCdqhLn4nrygqUh8KzdP3lBz52u+686dxUByEhgOQVKlskFiP6larOD3
X-Gm-Gg: AYBFou2ufa2MY38In7HHp03FL5jGrLWwLu8Dc4M5T6qA3qK0GG5QGCL6dUZwtIUaf7R
	PbgK6R4ZNXcXDFwzFlPSwrdzs45veASf6O+K6vjxOsm2n38aELyZ2NAFccjoFavorzZGLnTfN6j
	1rigJLjYn6WHPhGJ4i9ojj0FsAlRv2RXpoH1+1/0LpLlZlJ7PhOnOgAwTEuZ7VrGRIXyXtCSctY
	75eVkX4ZU63c8yP/gVXboDEFL9TFiXDwDA+CaivxB+RHpr8rPgHa8/o8ccSxpJ7RsTF12smob7i
	d9SGdDf+Q3B8+bS9vsONurtgsel0dbsPQLxInq96EkQoLGXoouWwdYLYwZsUh/ImcHe6u7oD87/
	cRvz7X/ZPetDviZVp96IhkRLcKz7UzO3GnBTpog/8uTgdwscyDBTql0gSwMPlqYXlrev7r35+Cj
	ad33W4zslhAXrjtgQ5hz1RcYvi9uRkbctosDDzC3DZChf3xyZEU1sFwJztz+KTDd1v4f08C9Zfi
	NfNS1w382bBd8UehcDzxxEa3H9oFDEXPifjKMTGqQuUsa5XNh6IUzYYdJDoCfVYVdWpqS0DLQ6E
	4xzUjau6sCQvJjfJu3Z7Qbw0LOgcNvQwnWMEFYIjfn9brVM+pz7gQu//plMUils5DXNNcA9J3uc
	pcFkCV+YHOK02jZ+hCjtaNsT37GcPn4G+edwu8v+dZ9d8iwM=
X-Received: by 2002:a17:90a:c88c:b0:3ac:d79f:8229 with SMTP id 98e67ed59e1d1-3ae8984cf7amr3599348a91.61.1793421654153;
        Fri, 30 Oct 2026 21:40:54 -0700 (PDT)
Received: from localhost (n106-71-19-159.sun21.vic.optusnet.com.au. [106.71.19.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae8454327esm6093012a91.4.2026.10.30.21.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 21:40:53 -0700 (PDT)
From: Aveline Noir <jm5905938@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 Shuah Khan <shuah@kernel.org>, stable@vger.kernel.org
Date: Sat, 31 Oct 2026 15:36:00 +1100
Message-ID: <179342136087.2.16978105493403840270@gmail.com>
Subject:
 Re: [RFC PATCH] selftests/damon/sysfs_memcg_path_leak: define ksft_skip
In-Reply-To: <20261030044643.157105-1-sj@kernel.org>
References: <20261030044643.157105-1-sj@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi SJ,

On Thu, 29 Oct 2026 21:46:42 -0700 SJ Park wrote:

> Define the value at the beginning of the test.

Makes sense to me.

Thanks,
Aveline Noir
