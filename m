Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795533967;
	b=xXQDnD4qqFYsU8vv3INKUJV0SpMWa/fdZUYZHJGMe3M6tz+VdKf3k/K1cGeHvUIvHSln
	 89xAaXQyB/MNNp+vt6I6spxURy7SpdoadrYVgzQxxhexQKaVEXq3TOu1+2BOKfIgoK5m/
	 +o8Y0v6/CAx8EJ0zCfB5GW8YqY0rLAqXUw2V7/LAu2aXMjdgIz9mO/ylqnhEbmJPsvAfh
	 3SlRyzLpihsU/uRBUxHYujps7R6keHjTRo8zdtZUYjP4hpTagCv5JmAqOcYhjxr3i2FdV
	 Ov9MphmNfOKfl26xb+7kPRfCp/nGND+Y5pXa4rvQuaOpHWKGo7KdBALgt6XrQ9dcxyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795533967;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KXih1WZAZkIstn+6lWF6B70S60ZNK5hxr3a/V9kUdq8=;
	b=wjcRdK91x13akg2h3rblHRPUWVlGjE/n67gF2HlrCvCMppKnQ82pUjSs3f3M7GHDzkDg
	 4EoU6X6kMdPYF83tV/gOInJ5NbDrUhgt9yiBDUP4eCm2j6JA5S6DRldFiEXN3fFW3ViLT
	 SEWH0/hmFPrzlWBBoOwag6Be1lBbUU9zhZYPmAe+8p3kfxtp+hnyYyVSlGfon74A9Q+eU
	 XAFKJFcs6B9fiQobpFX5S7VpVbQ1AQD20FQRD+mdYPm3w7IrSKyfI2Lifv4HcUvBSqsQ6
	 ryH3KEzJjOL43ZSrgyKM5Idqx5SbM0ZTZNzbDV+0nMGUuiJhK8hcogKFVCHvc8WLbaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YnmUMNd0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA58606A31E
	for <damon@lists.linux.dev>; Tue, 24 Nov 2026 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YnmUMNd0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D471F000D8;
	Tue, 24 Nov 2026 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795533966;
	bh=KXih1WZAZkIstn+6lWF6B70S60ZNK5hxr3a/V9kUdq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YnmUMNd03FVBwCygi2End4XljhMQngJcvukA1YboBhvs9lvrFT7GB0wwo13w9olrY
	 8+BOUVRmfTO2fD8Xn0gHIPP/kNlWYS8MakZ9k/myC3Xml85T14unBesAnkmaVdUs4e
	 DuzXQ1NjPj5hcf96iLkyXRlAu3LpLlUgfF9kn6czuQnhtU96L6mdZfsiwhI8KeMkOM
	 Pd9t5EUHmZpZdL45C/fNCK+8spzjAJDJfMpy7+YYDzp/gge2wFnHjfimema3+PZlfA
	 NSKKt5D0ZkjozusYa1622jDFoggb59Inx7Qoz1o0H6870OlpSPWqRkRGfzUIzvSgZH
	 at2ZkYz9a7jWQ==
From: SJ Park <sj@kernel.org>
To: Enze Li <enze.li@linux.dev>
Cc: SJ Park <sj@kernel.org>,
	Aveline Noir <jm5905938@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lian Wang <lianux.mm@gmail.com>,
	Dawei Li <set_pte_at@outlook.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/damon/sysfs: skip registration if DAMON core init fails
Date: Tue, 24 Nov 2026 07:25:53 -0800
Message-ID: <20261124152553.89020-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <835e8def-f4cf-4422-849f-08ad42f47c8b@linux.dev>
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

On Tue, 24 Nov 2026 20:31:46 +0800 Enze Li <enze.li@linux.dev> wrote:

> Hi SJ,
> 
> One tiny thing in the commit message you proposed, pls see below,
> 
> On 11/23/26 23:36, SJ Park wrote:
> > On Mon, 23 Nov 2026 18:51:45 +1100 Aveline Noir <jm5905938@gmail.com> wrote:
> > 
> > '''
> > DAMON sysfs registers ints interface even if DAMON core initialization fails.
> 
> It seems to me that "ints" should be "its".  Other than that, everything 
> else in the message reads good to me.

Thank you, Enze.  I will fix it as you suggested.


Thanks,
SJ

[...]
