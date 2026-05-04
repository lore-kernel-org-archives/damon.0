Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD013E02A;
	Mon,  4 May 2026 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777878134; cv=none; b=jMFuXz6r92eYbJz8Gjngzati2y/HHvIEzYbbuyDMopc5znt9hk5Ja2Y2KyHyR1Py+5yrqlWZQwX6MvtBsynmcOi2AeKX+eQBemGpPt4nKVC8h01uXO+PcigNbyV/w6oG7R2WPYY/10lja//MCfJ3vj2nf+YQfICm4RxeI1qxJnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777878134; c=relaxed/simple;
	bh=WLpJ5f+a4wMEBWCfEL3kr5VDnmwptVmJoRoK6QRwUjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mj/R5o9Mq90UiMnhQUcTbsj36+Vyq9j468+/6r6afNTmWOTJHvdZJbo4Wx0dXHcPeG5GjAvH9hw9Qx/p+gdCaEvNXI8VMbDyExGbEuuJd8KM1cU1AOgW8J22vymuJOZzzggOqGBkt56H9Nd5infvdU2oeOMZybeyu4P/BmTnBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaLhgUAo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaLhgUAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C02C2BCB8;
	Mon,  4 May 2026 07:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777878134;
	bh=WLpJ5f+a4wMEBWCfEL3kr5VDnmwptVmJoRoK6QRwUjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GaLhgUAosc+V0WZ+RiOOhWGBvH3Kecwiv5jZRsGPJSx4pchQ+zVABik8uUMZk3PEp
	 kALenCyCSPdCqzBB2ucIOeCQSw8x+xS+6l97ZQW/bmvQli4D5HxrzRZGzHJpDvzPG5
	 gFF2wbVgyJ3MqUGGPfWFCIpYawZyV9IdduL2tP9l5ePC4kBA6A2nTo0QrlQTGgBZAF
	 xzJ2/MACyGPPvX3XPPDP691N5L0+MKIpgh6Rr6vV1WDCcz3v6SQPjk2JlyMD0iR79H
	 ETCI/MRg6j4bibdJiyJBvVPmNoxQ45bJq1e4H7ZG7tGssTQFICOD2v3RaPxtfI9ZgP
	 3sfNcBk1NqfFg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] DAMON Updates: Tiering, Pagel Level Monitoring and DAMON-X
Date: Mon,  4 May 2026 00:02:07 -0700
Message-ID: <20260504070208.7106-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260426213545.94918-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I uploaded slides for all DAMON LSFMMBPF'26 topics:
https://github.com/damonitor/talks/tree/master/2026/lsfmmbpf


Thanks,
SJ

[...]
