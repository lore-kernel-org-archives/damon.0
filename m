Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E88362154
	for <damon@lists.linux.dev>; Sat, 17 Oct 2026 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792261771; cv=none; b=qzbyBtd55xqt4B6quFqUufxZjNVj7X+FuXqPgIsZrdek3568iXbveLomUmunPoJZBbDrLzUF4zz6wLS2PrCbm+FoCeNiiv6wyOhO4tA5m+UkCNVtRdms2/4IsfC0hF4B+X1oh/E+j7Q/HwiC3AQtxkXiKGZvM7If16TA0QNqKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792261771; c=relaxed/simple;
	bh=TgAolpnAhSBh/17k5PcAoyoFv65m2zAwIYCs6CTpp1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYOu9/zwIMAHLzAd3O0Mx3hIaayIjYJ4TNhFzcxPSIBH0qu189WZzxG0DdcLsWJjpGI4s3+wP7nQAAi1Il18sJd4gVwSx/AYfwx3otXlYUlbUlyoKF/D4j4n1qcEqVuUxDJR44/aOCsG6wPx4UFexbCVWKtOy8tX4/NesEAvMrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2+NL+6U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2+NL+6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778971F000C4;
	Sat, 17 Oct 2026 18:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792261770;
	bh=5KGU5q8cBlumEIb7orONuHIQAYPYOYxo/mwaNUfr/pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b2+NL+6UP8t4FH9Qw+7UNefqur6D3bUtmJr7JIplHINXEAqTts0PfuiEyR1zb7GSQ
	 l5lqdWd2LelWRhXoGX9OsztFKff+EBWnPf96LK3LeaXrzUBtka49RmJHQVzo2kwHFq
	 ZgEaoVh/1/nmSW+D88iuFS59ucyy/kVeSM+UKuaC/JIYSYFkqIfNgzZzuZO5GFo4cM
	 nrQNt8ZTm+vkhxrcfHBBLb9rRj7BQ0/l8LpZZFdpMGzV3dgsZuq+NI6D/eiQytEaAK
	 JT/mbZZaEO4lK074dZ1GDlaLEbEqzS0AhJcb0mZCJcumQC+tVHdRhHzbslk8gKK9u9
	 LpOMLsEWuQ6pg==
From: SJ Park <sj@kernel.org>
To: Karthikeyan KS <karthiproffesional@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev
Subject: Re: [PATCH] mm/damon/sysfs: make next_update_jiffies per-kdamond
Date: Sat, 17 Oct 2026 11:29:22 -0700
Message-ID: <20261017182923.88838-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261017182212.1450579-1-karthiproffesional@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 17 Oct 2026 18:22:12 +0000 Karthikeyan KS <karthiproffesional@gmail.com> wrote:

> Hi SJ,
> 
> Yes, my patch is redundant.

Thank you for confirming.

> I should have checked your damon/next tree
> before sending it. Will do that before filing anything going forward.

Please refer to this doc [1] for related trees that better to check.

[1] https://origin.kernel.org/doc/html/latest/mm/damon/maintainer-profile.html#scm-trees


Thanks,
SJ

[...]
