Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E50A1DEFE6;
	Mon, 23 Jun 2025 16:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750697527; cv=none; b=HFQBuUmjsImfq/p8GUnB92P1+MFnh9QhT5xn+EspAwW2IhAgSr2v+yvI71seHAh8FapJ8+o6QQ/LPmd34Ce40nLIxGQ26dMREU2HFSP0UTPNEG8rzVCzFmy8qFTmP88QQQpp5GPpNjOm60+FLKLlg8/Y0dLXRX28JYFvvFOOBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750697527; c=relaxed/simple;
	bh=Y7sP+puX2OrY+0D3hBfAwoGfsII2Xitul45T9n5nxzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIWmamL1p5HCtKCAcYMquZ/0tOIOWY0ID7KopGfaPgb7pI8xp2cH/v18ICR9PXA3WNSQ0fj4gnMGYZHBN67v3wYEjJxW6Wi5AZhXyZ0pOcZ+qhcfke4vn8Werg+yaOhPIVt8cUnOe6Lo1vdLCsC2x5jwfvAEQg7j2c5nYv7e3jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lzr1Tc2V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lzr1Tc2V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB260C4CEEA;
	Mon, 23 Jun 2025 16:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750697527;
	bh=Y7sP+puX2OrY+0D3hBfAwoGfsII2Xitul45T9n5nxzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lzr1Tc2VxFkVYqpfllcuhzbzf+2t+/PfA/KWM0sleKHKTipuQsNfJFhJZicUCp5e3
	 DHXEnveQamYcTJmoCvIL4ALTZRh1yZEY87dM0YUJB5r770lohqcoMYoM6z+n3ruNwq
	 1k2xS5vJIKvXQB4HOEEwyDheOaQADxbEJrsub+FKQVv0kcUha+wLcD2aME/1+MzyxZ
	 LRTwVQx5Fmvl1kKP5J5C5UXHZU2ICWp8+0IXvkIeKi5sjg18xBYaK4HJzA6GaNfJm3
	 6b/XMSR1ILnDs89TXzYzIOK1BWqb3uAu1NeOI2iR1YF7XInGJI7OvXnhvAyZX4nLrJ
	 U9kVIynCxiLmw==
From: SeongJae Park <sj@kernel.org>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	vtavarespetr@micron.com
Subject: Re: [RFC PATCH v2 2/2] mm/damon/paddr: Allow multiple migrate targets
Date: Mon, 23 Jun 2025 09:52:04 -0700
Message-Id: <20250623165204.43486-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAMvvPS7ozBjY-YWHrkkGVQA8ug=0=xT=BeyZxi0YrHp6PNQmHg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 23 Jun 2025 09:27:16 -0500 Bijan Tabatabai <bijan311@gmail.com> wrote:

[...]
> I think my comments about the round-robin approach also apply here,
> but all things equal, I generally prefer being deterministic over
> being probabilistic when possible.

Makes sense, let's go with the roun-robin approach :)


Thanks,
SJ

[...]
