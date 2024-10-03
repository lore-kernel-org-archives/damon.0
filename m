Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D11A4F26
	for <damon@lists.linux.dev>; Thu,  3 Oct 2024 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971210; cv=none; b=dnmmv1hzZlDNwq2HeWDI4R6W9SEQRG+v4JSf5wceF5eGv++Pj7tBB8KlDK5Bgoo1zheGfgBQ70KHamZecwH+jdceExrQiiADXhPsqH/Au/VLXMiRwlGhZJfUa/RAYVvvbUPKesrtX04w6xUpJoAQDbBVhqd+6DqJUss0ek3PhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971210; c=relaxed/simple;
	bh=yTKy+msCiJe8GTrzFPLa58Vc2IXw1KemCTQwGxTFuw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GvNZKyPhNFStVgFTLs9ifmeeuJcf6pVNFFFYzZWi7Tns0MHwefHkzQDYln5opCMicQQ6LMiOAwmfGi3g7DebW0zG17YbnIBK/jH5X+9QNPxT9gZrGQSX0X4NErZzWuQZreV0+PARiVsKcfe34xiKNivwcfHxzTcjw0zwHH2bS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8OZmKHT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8OZmKHT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8581C4CEC5;
	Thu,  3 Oct 2024 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727971209;
	bh=yTKy+msCiJe8GTrzFPLa58Vc2IXw1KemCTQwGxTFuw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8OZmKHTVkWMYoM+RHsP+5TD0F5fI3FdxI8oWzqoPK2Twb6oaI52lEEbKRoOHIt4s
	 Vptcj8yf/8Cqq7o5G4BLHlb/XrdzZU3EwlgFbPWd+ipxEHNkFX9eMbF7trLVhBcNZN
	 27x6NJ9N/7EGmlaoVALidQuvqzGqah5zG7MMLIZk4qQmNg83OfUj5oK2EUJendCrmC
	 QcKW0+30vq/oZ44shQmrRRugPjf2r3mUMSKgrMGP9rG0XP1RikvX0+Ihi69BBDuEkh
	 1J9MhWF5qUAyGwdt8lL1xwpIq0oBLonQpY1WXd5S1cYQ18UqX2L5dm0ITTsfibUo4g
	 xPhWS0Evtd4WQ==
From: SeongJae Park <sj@kernel.org>
To: Bhagyashri Pathak <bhapathak@linux.microsoft.com>
Cc: sj@kernel.org,
	damon@lists.linux.dev
Subject: Re: subscribe
Date: Thu,  3 Oct 2024 09:00:06 -0700
Message-Id: <20241003160007.64618-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241003121355.GA22390@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: sj@kernel.org

Hi Bhagyashri,

On Thu, 3 Oct 2024 05:13:55 -0700 Bhagyashri Pathak <bhapathak@linux.microsoft.com> wrote:

> subscribe

I'm sorry but it is not easy to understand your real intention of this mail.
But I guess you might wanted to subscribe to DAMON mailing list, following some
deprecated mailing list control instructions?  If so, thank you for showing
your interest, and welcome to DAMON community!

Nonetheless, this email wouldn't make you be subscribed to DAMON mailing list,
to my understanding.  You could make the subscription following instructions on
https://subspace.kernel.org/subscribing.html

In short, send any mail to damon+subscribe@lists.linux.dev

Pleae let me know if you have anyquestion.


Thanks,
SJ
