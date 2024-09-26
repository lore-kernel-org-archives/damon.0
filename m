Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127811714C9
	for <damon@lists.linux.dev>; Thu, 26 Sep 2024 21:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727386786; cv=none; b=Dpcgkz4Bhr3e3nMOpARxflRn6gdrAhaImtmD1PY7ZtL4k7xXpBFlXzD4X4LgDRqr0QQ70ko0pF59Ui0T6d5XkwNG/ubVopmpo68stfxx+mq+AK/Pn3PIB0lyJYLxW6tNcfUod9Pua0vu+9SxUwYqmC47dDJ6KG5Rx5EzOwgt9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727386786; c=relaxed/simple;
	bh=dt7tynU6k9rKZRtDTsB7FRtsBTgfuH6TacDfSXgShCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIVMlq/YZYzjET0hIc+QaUv0acvdvnI4MATeWuSPBmi7i4bBp7c5JIhpoSaT8oeR4XrzaaKLEWArwSenP9Pf/RcDUb1StWBAowVMU9Im2Y8DvX7PvohXzuAcNyayyjQMWdsqvvb75F7Ad21m/wEmyfAJhcjnifOOYqoqOOW9JEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZD+WmrU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZD+WmrU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFA5C4CEC5;
	Thu, 26 Sep 2024 21:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727386785;
	bh=dt7tynU6k9rKZRtDTsB7FRtsBTgfuH6TacDfSXgShCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZD+WmrUIJ/oB8akk9lNdigZAjetEjFjSOOPhzrelqt5A8W2F4hCQi91i2eg2h+4f
	 Q9GKz1EN+qc6MUipW5HtnWxB+JweQJrievUtp1aUXSgxvrOG3xtvGqT8runMn8xg3R
	 nMaHBbD8qal3dv7B5hUbh/wVXgfOd2H1jdk17XLvo8jZ85R76+9ccXfaw0+wpP5kMX
	 KMM23wr7sfQ351mqLmEjqFcM1iPLwp0lz9td5+NfKf51anNEF6MS8qmnfJsyPXBlVH
	 MaGBMe0fyjIyaOy7uNMYHu1yrucaWn23ebAqjhwX9O6Hn9u14sAWOrB1mKG/mViGHD
	 QE4wQlOEHhAMQ==
From: SeongJae Park <sj@kernel.org>
To: Yeo Reum Yun <YeoReum.Yun@arm.com>
Cc: SeongJae Park <sj@kernel.org>,
	"damon@lists.linux.dev" <damon@lists.linux.dev>
Subject: Re: subscribe
Date: Thu, 26 Sep 2024 14:39:39 -0700
Message-ID: <20240926213942.17022-1-sj@kernel.org>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <GV1PR08MB10521C8CA9CE7D0D1C2AEB211FB6A2@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yeo Reum,

On Thu, 26 Sep 2024 21:18:37 +0000 Yeo Reum Yun <YeoReum.Yun@arm.com> wrote:

> subscribe

I can't really get the point of this mail, but maybe you wanted to subscribe
DAMON mailing list?  If so, thank you for showing interest, and you could do
that following instructions on https://subspace.kernel.org/subscribing.html

In short, send any mail to damon+subscribe@lists.linux.dev


Thanks,
SJ

[...]
