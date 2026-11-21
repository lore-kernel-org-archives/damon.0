Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795296139;
	b=hWkt9kCQABcicDT1CrNG6vvgAnBF1bHHV7t0m1q+8SrcaF2SbYUf4ZZFWeoViu/fh7g4
	 qKvz5q7VqKVmRKYQ055o4RAg4SnbkVKDE2WSEaLoTDEBWs+rGR4JOU5ErLLfEL1hgUARN
	 UKmQSwUTP5TQJqnvablHF9/BtBwCclYmUkRi96519ru5xc/kFaqpeys1NQSsUxb6GlEHG
	 r23Rb9i7gAiGedMIm9ttXWEEqVKpiJ0WZoLEYmFYZ7VUNNGnExOw5nFCC6Mm3/0NmbahW
	 mPP2Ymc8kQz4QKiGtU+lJfywIQDmXHgan/P8WMBMD+E5U+kP04gm8JpzJdfRq7NiWJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795296139;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sBeiyIH7gMM3aoWsWeyzBdNbI0kDC6nmGHL/xgQXibw=;
	b=P+aYmEZz6yA4AzaCcnJJI0h/XU2KNF5sbzONYrXORJGQgopAcpMhSeUZM8L0O/bwo/3e
	 lMzfhcC7SLrQCrZm1qkz4BtzyxbybJvrStNe+daGofac56kR/PAAypBfDwoIuvVUyF9qA
	 2Z1UuJSyHc/XsAg1lXC/AQvY4jwSYgzKqifr+OJ+siVeB7jGgKJ9ZgCvgWYhC8GtWH4Yh
	 2Ar77Jei3c3e/S4bw1LGdxWHYiK9G0HRJvxggDJ6Ln31aNlswZSDauLTWep48QByguRkq
	 R5kACGd5irih+fOB7Vno8tLx7DqehAZJB3YYlZvrLBourb6IoyccGLtYq1yxQAUaEpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cu14TLOp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28303606A320;
	Sat, 21 Nov 2026 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cu14TLOp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88121F000C4;
	Sat, 21 Nov 2026 21:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795296139;
	bh=sBeiyIH7gMM3aoWsWeyzBdNbI0kDC6nmGHL/xgQXibw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cu14TLOpT2TjVU8lZhc/3GKBEQesCHMkSbSw4aUDjfjaSZIko105T4YqcbfG5TDmT
	 VsOGvvuh8ptLfANdFjinpSNpuQeaLPMhj5rJIqe5PhsTQXBnPpYpICISWeINRVlc40
	 WAOqTLo+Hq+zTJlg2LquVlwZQkLzGg4nDqPb5goEWbdwG1MyaaZH52Q+qeqZMWztpU
	 kwJ/Ii4FpiuHwoknwYuXqPjR9J3svmTVRZG6+iuurFtTTblOcSIKXaEbDEMKFnED1K
	 hSpGG3thI7MBdas8Dae28uB62B3EvrsD7xQvDTVCXbd0xBP1OPUJ9nmcnYlmUDMTjZ
	 QJQiHMCX8Ij/w==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 00/27] mm/damon: let users report their data attribute findings
Date: Sat, 21 Nov 2026 13:22:09 -0800
Message-ID: <20261121212210.131528-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: 
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

On Sat, 21 Nov 2026 12:59:44 -0800 SJ Park <sj@kernel.org> wrote:

> TL;DR
> =====
> 
> Build a system for letting DAMON-external entities report their data
> attribute findings to DAMON.  Let users report their data attribute
> findings to DAMON using the report system.

Sashiko found an issue [1] in patch 14.  I will send v2 with a fix of it.

[1] https://lore.kernel.org/20261121211922.131352-1-sj@kernel.org


Thanks,
SJ

[...]
