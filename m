Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FF615666C
	for <damon@lists.linux.dev>; Thu,  3 Oct 2024 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957637; cv=none; b=H3rlnl9kcKAPDIHdlDiQtApaLpsqpGvSXDWOyVaWykC7Db6P4nnsrxew3xf8uQtqsMcQsn6z/vVMXOgrLb69GxXnJe+AWqqHGEDKRHNqH17kx6w30OFyiBgJxZd3OVwAnL2beFJC6teh2sAOfAg/fTmBO2Bi9q/xNnLthKw4Sd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957637; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mOpeX8AxXKlxpyaTuBH3duQScbyxZqiSml3tthF6tRPhDdOPLvWF4NdBEUTWBtw+il1u8UkeG4l+6+kqMQOqI5Yogo5Uq6wkVan8WhRxyhCjFkeqhIqz5i+9BgwLaisrw43mX5lNLVYziLoLbuXcAILIhPrJXEPJwR3BZa3vYyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JMOUn6fA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JMOUn6fA"
Received: by linux.microsoft.com (Postfix, from userid 1207)
	id A8B8C20DB355; Thu,  3 Oct 2024 05:13:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A8B8C20DB355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1727957635;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=Date:From:To:Subject:From;
	b=JMOUn6fAQjWUc6pbxL83gj6OsbPDmBMdU+CKsxUIaL6WMqIuZPm3XrZRw+sJXsGBU
	 TvMZaxbLb2sZcGAx/XeC8ddHC4AibG5rdzrKuwrQZFMZQkj1ymRSu73oOhQb9IhtxF
	 Jki88gJ912gnYl/ltTywh8N+UZXvYkRxrbiN4GUU=
Date: Thu, 3 Oct 2024 05:13:55 -0700
From: Bhagyashri Pathak <bhapathak@linux.microsoft.com>
To: damon@lists.linux.dev
Subject: subscribe
Message-ID: <20241003121355.GA22390@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)

subscribe
