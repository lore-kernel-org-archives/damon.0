Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7C3AEB39;
	Mon,  1 Jun 2026 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323764; cv=none; b=Bl5mj/2o1bn+QvtAphewTlYxOUCzVIuaplg/AOcqA8AYAJNOzSuq2fLRVdP6vEtqDiHims/B18o0p1OgOcu6aSeHrDxgq2PfsiuzXHv8wU5g54/IWsExjJXNXy/qLbZlBY22qmppNR2RxfHFBdorbkGTQ3E4rLk3zaDvZjdRAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323764; c=relaxed/simple;
	bh=CJq2cFBmG14UvwiCxmgjiHnVptheGLoBGxcsHnoFS2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e26RvbM63P4Uuh3zFu/ylwIf2o47AHO4/vmjeBpWQoB1nVgVzi6ChUXLRan9tVB05H8TXbB7kEti5WbjdLoH/vNBibIKPsGqAm7NkxOL9B1AgGFApGjK6jWyJw1usa1Y7D/7ImOXYcd/YMRFov/Jp08FRBou6t9ksG/0ynN+/K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiKQ15m8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiKQ15m8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4F51F00893;
	Mon,  1 Jun 2026 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780323763;
	bh=Xb9w3aa2+NN2w8mM3XFth5LPOZJyIKQb/PyqpCrSq3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RiKQ15m8NA69rpL0S4tXOXueTA3Eh2CzXehotde7DEgbVF5txXf3QUHJp5BwrH+Ef
	 PCOMLFoHhJpLTXJVgA0PWwWf6RrcQRUvaNu44/zbMSaIrBolFDAeajSLxhcmEjl27a
	 TcQQxGDb7p7Cml00flwhT++TDnL1MFD2/q5x97xvN8frnQhtVJKA+7HbLZhpGxy3iH
	 lyy6Rbu8DNx/59AcgsExWyLrY2A3D3gNgSjukrSlDBEIMqF6T8o9rMkf8iCbfzJUQG
	 B8pxHQYeZ6Q+IM/gqiycdg7FoV4Q/JB57emE7DraJLqTSpBT7JLNDiE4F0Lkxy4ebY
	 vpB9TzxvO6fpw==
From: SeongJae Park <sj@kernel.org>
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Kunwu Chan <chentao@kylinos.cn>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/3] selftests/damon: misc fixes for test bugs
Date: Mon,  1 Jun 2026 07:22:33 -0700
Message-ID: <20260601142234.111301-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601032314.424013-1-kunwu.chan@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  1 Jun 2026 11:23:11 +0800 Kunwu Chan <kunwu.chan@linux.dev> wrote:

> From: Kunwu Chan <chentao@kylinos.cn>
> 
> This series fixes several bugs in the DAMON selftests.  Most are
> trivial but cause tests to silently pass when they shouldn't, or
> fail prematurely on slow machines.

Nit.  Only patch 3 fixes a fake test pass for "avail_operations" file existence
test, and the series is not doing something for slow machines, right?  I think
the last sentence should be updated, for example:

'''
Most are trivial but makes test output wrong or even silently pass the one for
'avail_operation' file existence check.
'''

Other than that, all look good to me, and already have my Reviewed-by: tag.

Asssuming you are ok with the above change, I applied this series to damon/next
[1] tree with the above change.  If this series is not added to mm.git in short
term (~1 week?), I will ask mm.git maintainer (Andrew Morton) to pick this.
So, no action from your side is needed for now.  If it seems I also forgot
doing that or you cannot wait for my action, please feel free to directly ask
that to Andrew.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
