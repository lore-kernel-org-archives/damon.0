Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967232;
	b=In3YcW7QxeWh/lLN/k4sWgempZu+RsZoFZjHoL/29rzmoSpgAYHhczfYjQHkLik4s8Je
	 HbVna4HPvUhF/LEFJ2io2zHYf5GKc/UT6/Y8fzenfFT1XYMDBHB5Tl766u2nzzjUjt6CU
	 aWym/LBhrzxsrgdqDBjIXv2bvXaaAyOxNxRkvGL1ZPAzaAJ4mirf3wQwgNBWkuVbjOloQ
	 F8KLxowF85nvUSR5M2kRPivCVUNHHbE5sqbkddg3FseX4RmspQu9Nsdudlwm+oeV7eM3w
	 ak2JDOkPWLCcJVnauAoABg6SmsUYMQ/7U3BkogSZqP73SbMMhuDaAhPnm+xUXEKjGaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967232;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2gdho5K/JlFD0r0e2kCZivjc5YfVDRgpJ3DbV/tzMlg=;
	b=kC/QPfA6DpUt8H+voiF66e6a0TLaDygIouDV5moA1zS73asqnuz1MAgKmTp1ipgnyyQ1
	 uN05CcnQhjyjMVQxWS6ooNsUaA6V4/DRDsbZn1Uwyssve1kWj1oGqmAGl44ww0SZWUkoD
	 ZdYh6m80XlBYYSJJ/klBSmJ8T3OaJLfYbPCVkwKl8BXq05Nn107HifuP7THlucuygBzfq
	 vzCdVt7D6Rkmri6w0qU5LmEPIK5pKEzpP334HOq3KEUEgGiod1eXqLQhQmqqsvGAkoF/5
	 hTHdbvc2Ypu7mZX/5lmXYO2+ODwp12kPac0rmBwY1qgNxniZ3GPqP/UBar0l6paSaBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYXsdtTD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982A606A325;
	Wed, 18 Nov 2026 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYXsdtTD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D1C1F000C4;
	Wed, 18 Nov 2026 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794967232;
	bh=2gdho5K/JlFD0r0e2kCZivjc5YfVDRgpJ3DbV/tzMlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mYXsdtTDCsA/G2cB9aWifx3HlZtcFdP0G3GuyTu4fNiJ91gDGzT7qe+QSEpAipXew
	 omLKf1qYKxxyuJYgsLiL182a5d/bHFbTFl5sqQGObEQ25s5IT2vRuDOATmUVCjsg2s
	 1q1ujRTsCp3KKkeY/Wuq9RanKG+0mBqj77nslOZpbHBW/hwQN4oXB34ZSLzPHytAkk
	 mcoXCApif23tP70qMPjGSx0/PU+Ae5hQZdJ3WvHS0jlSVlNzLIv86kc/bcDd6WgtDk
	 ZVugnoINPfkhST/kRQVuzJ78oJdydcPiOsd6ipYOY23LjOCntukhABVPTPPbI7Y0QN
	 CdzNiHSrH2JRg==
From: SJ Park <sj@kernel.org>
To: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mattathias Pinchover <mattathias.pinchover@uber.com>
Subject: Re: [PATCH v2 4/6] Docs/mm/damon/design: update for sz_ops_filter_passed_last
Date: Tue, 17 Nov 2026 18:00:24 -0800
Message-ID: <20261118020025.97097-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261117-damon-sz-ops-b4-v2-4-439888fa04ac@uber.com>
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

On Tue, 17 Nov 2026 23:22:18 +0000 Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org> wrote:

> From: Mattathias Pinchover <mattathias.pinchover@uber.com>
> 
> Update DAMON design document for the newly added DAMOS stat,
> sz_ops_filter_passed_last.
> 
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
