Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4CE261B9C;
	Sat, 21 Mar 2026 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051383; cv=none; b=S6PW8GRiaB/rkasA+NDo9NAMA9sf8tZDFuuN5Taue1dNdgN2Mhd+4MIf6eBJacImJtq1WB+LGuKQYT7GXYQfz5U3uWfSCXx1USuPLHuVUre84VVaqaIYnSji4kXbmXmXH9Adybk3t32j4r7QTHEPAokGKZjRf9QB/4Ha6i3G224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051383; c=relaxed/simple;
	bh=ZhLgMTxTqhozNm1gYYPDnW5zUUjGgwMJlwUn+I+KLSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jc5O26GGaAKiiVa8dX6EmDtt0qJ4j84s1donZ5c03M6DwYCUe5pYH/yOFircaoTwd7Rb1sY1qOAO7ToWMLouWv50QeGvrWigBeVTslIocQph7oVsaBR09jg1n3akxwdwX6xkg5fRWTRAzj8ZYw1BiuC28XjrMXPnUlZIwY1ZVIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d44ms4oT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d44ms4oT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FABC4CEF7;
	Sat, 21 Mar 2026 00:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774051382;
	bh=ZhLgMTxTqhozNm1gYYPDnW5zUUjGgwMJlwUn+I+KLSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d44ms4oT/uU2JUEIpcp/yUVZBpfQpXMdi9ZJ0XFFkK2x9NaGIQMw8vtwQAGwNl/ei
	 ogVrtP0zRTwAcabz9UZqZXdp+zLoj/dE15Oj0tKtSLmAlwA5Iq8fvQx7m6j7xsyVn2
	 L3zuQ7tz/uT2cOh1n0F0KMEdk/eHr9B9cpEiP+s4/YP6R4I3sw1YIEZE4/Q4fTFWsM
	 u8h2HA0geOtqamWIllqzxaPONCdZqJlfN4hX+tD/iI9SS8gjck9j8HU1tT9jyjH1JP
	 7oMgN74R78JbjthoJjomlGY06+0AGOgK6Sd1pyrExRrdgaB+Gw0tVJWZfF4v7/6UhO
	 GtbzTGEau8vtw==
From: SeongJae Park <sj@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/damon/sysfs: fix param_ctx leak on damon_sysfs_new_test_ctx() failure
Date: Fri, 20 Mar 2026 17:02:54 -0700
Message-ID: <20260321000255.102944-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320163456.177750-1-objecting@objecting.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Apparently this series is only by a mistake, and therefore a new version [1] is
posted.  So I will skip this series and review the new version.  Let me know if
anything is wrong.

[1] https://lore.kernel.org/20260320163559.178101-1-objecting@objecting.org


Thanks,
SJ

[...]
